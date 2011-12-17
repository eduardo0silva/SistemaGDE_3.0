class AddAdminEmUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :admin, :boolean
  end

  def self.down
    remove_column :usuarios, :admin
  end
end
