class CreateReportes < ActiveRecord::Migration[5.0]
  def change
    create_table :reportes do |t|
      t.date :fecha
      t.integer :referencia
      t.string :descripcion
      t.string :monto
      t.string :saldo

      t.timestamps
    end
  end
end
