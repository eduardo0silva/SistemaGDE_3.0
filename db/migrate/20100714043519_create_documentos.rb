class CreateDocumentos < ActiveRecord::Migration
  def self.up
    create_table :documentos do |t|
      t.integer :numero
      t.string :destinatario
      t.string :assunto
      t.text :corpo
      t.string :despedida
      t.string :remetente
      t.integer :usuario_id

      t.timestamps
    end
  end

  def self.down
    drop_table :documentos
  end
end
