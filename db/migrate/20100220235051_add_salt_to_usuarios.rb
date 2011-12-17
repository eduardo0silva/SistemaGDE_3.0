class AddSaltToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :salt, :string
  end

  def self.down
    remove_column :usuarios, :salt
  end
end
