class CreateEmpClasificacions < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_clasificacions do |t|
      t.string :nombre
      t.string :tipo_cuenta
      t.string :tipo_subcuenta
      t.integer :tipo_movimiento

      t.timestamps
    end
  end
end
