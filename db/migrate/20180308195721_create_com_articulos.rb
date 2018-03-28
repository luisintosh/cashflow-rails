class CreateComArticulos < ActiveRecord::Migration[5.1]
  def change
    create_table :com_articulos do |t|
      t.string :codigo
      t.string :nombre
      t.string :categoria
      t.string :unidad_compra
      t.string :unidad_inventario
      t.decimal :cantidad_inventario, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
