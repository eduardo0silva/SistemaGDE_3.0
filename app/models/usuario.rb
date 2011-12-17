# == Schema Information
# Schema version: 20100510165357
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  nome            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  encrypted_senha :string(255)
#  salt            :string(255)
#  lembrar_token   :string(255)
#  admin           :boolean
#

require 'digest'

class Usuario < ActiveRecord::Base
  attr_accessor :senha
  attr_accessible :nome, :email, :senha, :senha_confirmation
  
  has_many :microposts, :dependent => :destroy
  has_many :documentos
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #validates_presence_of :nome, :email
  #validates_length_of :nome, :maximum => 50
  validates :nome, :presence => true, :length => {:maximum => 50}
  
  validates_format_of :email, :with => EmailRegex 
  validates_uniqueness_of :email
  
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }
  #validates_confirmation_of :senha #automaticamente cria o atributo virtual 'senha_confirmation'
  #validates_presence_of :senha
  #validates_length_of :senha, :within => 6..40
  before_save :encrypt_senha
  
  # Retorna true se a senha do usuario conferir com a senha enviada
  def has_senha?(enviada)
    encrypted_senha == encrypt(enviada)
  end
  
  #lembrete de senha com cookies
  def lembre_me!
    self.lembrar_token = encrypt("#{salt}--#{id}")
    #save_without_validation
  end
  
  #Retorna nil não validar ou retorna usuario se validar
  def self.authenticate(email, senha_enviada)
    usuario = find_by_email(email)
    return nil if usuario.nil?
    return usuario if usuario.has_senha?(senha_enviada)
  end
  
  #Implementacado preliminar. Cap 12 implementacao completa.
  def feed
    Documento.all(:conditions => ["usuario_id = ?", id])
  end
  
  private
    def encrypt_senha
      unless senha.nil?
        self.salt = gera_salt
        self.encrypted_senha = encrypt(senha)
      end
    end
    
    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end
    
    def gera_salt
      secure_hash("#{Time.now.utc}#{senha}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
