class CreateReadFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :read_files do |t|
      t.date :fecha
      t.string :referencia
      t.string :descripcion
      t.string :monto
      t.string :saldo

      t.timestamps
    end
  end
end
