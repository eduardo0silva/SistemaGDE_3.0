class Documento < ActiveRecord::Base
  attr_accessible :numero, :destinatario, :assunto, :corpo, :despedida, :remetente, :usuario_id
  
  belongs_to :usuario
  
  validates_presence_of :numero, :corpo, :remetente, :assunto, :usuario_id
  
  default_scope :order => 'created_at DESC'
  
end
