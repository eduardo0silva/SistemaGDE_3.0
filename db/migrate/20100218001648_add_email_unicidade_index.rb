class AddEmailUnicidadeIndex < ActiveRecord::Migration
  def self.up
    add_index :usuarios, :email, :unique => true
  end

  def self.down
    remove_index :usuarios, :email
  end
end
