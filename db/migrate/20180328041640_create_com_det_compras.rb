class CreateComDetCompras < ActiveRecord::Migration[5.1]
  def change
    create_table :com_det_compras do |t|
      t.references :com_compra, foreign_key: true
      t.references :com_articulo, foreign_key: true
      t.references :emp_locacion, foreign_key: true
      t.decimal :cantidad, precision: 10, scale: 2, default: 0.0
      t.decimal :precio, precision: 10, scale: 2, default: 0.0
      t.integer :moneda
      t.decimal :descuento, precision: 5, scale: 2, default: 0.0
      t.boolean :inventariar, default: true

      t.timestamps
    end
  end
end
