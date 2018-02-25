class CreateEmpProveedors < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_proveedors do |t|
      t.string :empresa
      t.decimal :saldo, precision: 10, scale: 2, default: 0.0
      t.decimal :saldo_max, precision: 10, scale: 2, default: 0.0
      t.references :emp_perfil, foreign_key: true

      t.timestamps
    end
  end
end
