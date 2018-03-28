class CreateComInventarios < ActiveRecord::Migration[5.1]
  def change
    create_table :com_inventarios do |t|
      t.references :com_articulo, foreign_key: true
      t.references :emp_locacion, foreign_key: true
      t.decimal :stock, precision: 10, scale: 2, default: 0.0
      t.decimal :stock_min, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
