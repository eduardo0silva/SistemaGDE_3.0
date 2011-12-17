class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :conteudo
      t.integer :usuario_id

      t.timestamps
    end
    add_index :microposts, :usuario_id
  end

  def self.down
    drop_table :microposts
  end
end
