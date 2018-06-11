class CreateComCompras < ActiveRecord::Migration[5.1]
  def change
    create_table :com_compras do |t|
      t.string :ciclo
      t.references :emp_clasificacion, foreign_key: true
      t.references :emp_proveedor, foreign_key: true
      t.integer :estado, default: 0
      t.date :fecha
      t.string :factura
      t.string :comprobante
      t.integer :tipo_comprobante
      t.decimal :descuento, precision: 5, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
