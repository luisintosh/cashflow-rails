class CreateEmpPerfils < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_perfils do |t|
      t.string :tel_fijo
      t.string :tel_movil
      t.string :email
      t.string :rfc
      t.string :direccion

      t.timestamps
    end
  end
end
