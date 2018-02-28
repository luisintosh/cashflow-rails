class CreateMovMovimientos < ActiveRecord::Migration[5.1]
  def change
    create_table :mov_movimientos do |t|
      t.integer :tipo_movimiento
      t.string :hoja
      t.date :fecha
      t.string :ciclo
      t.references :emp_clasificacion, foreign_key: true
      t.references :emp_cuentab, foreign_key: true
      t.string :concepto
      t.references :emp_proveedor, foreign_key: true
      t.references :emp_cliente, foreign_key: true
      t.references :emp_locacion, foreign_key: true
      t.string :factura
      t.string :comprobante
      t.integer :tipo_comprobante
      t.decimal :subtotal, precision: 10, scale: 2, default: 0.0
      t.decimal :iva, precision: 10, scale: 2, default: 0.0
      t.decimal :ieps, precision: 10, scale: 2, default: 0.0
      t.decimal :total, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
