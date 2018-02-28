class CreateEmpCuentabs < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_cuentabs do |t|
      t.string :nombre
      t.integer :moneda, default: 0
      t.decimal :saldo, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
