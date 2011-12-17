class AddLembrarTokenParaUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :lembrar_token, :string
    add_index :usuarios, :lembrar_token
  end

  def self.down
    remove_column :usuarios, :lembrar_token
  end
end
