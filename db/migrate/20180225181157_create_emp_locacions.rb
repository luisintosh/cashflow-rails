class CreateEmpLocacions < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_locacions do |t|
      t.string :nombre
      t.string :direccion

      t.timestamps
    end
  end
end
