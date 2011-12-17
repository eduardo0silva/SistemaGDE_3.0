class AddSenhaToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :encrypted_senha, :string
  end

  def self.down
    remove_column :usuarios, :encrypted_senha
  end
end
