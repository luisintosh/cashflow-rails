class CreateComPagos < ActiveRecord::Migration[5.1]
  def change
    create_table :com_pagos do |t|
      t.references :com_compra, foreign_key: true
      t.references :mov_movimiento, foreign_key: true
      t.references :emp_cuentab, foreign_key: true
      t.references :emp_locacion, foreign_key: true
      t.decimal :monto, precision: 10, scale: 2, default: 0.0
      t.integer :tipo_pago
      t.string :hoja
      t.string :concepto

      t.timestamps
    end
  end
end
