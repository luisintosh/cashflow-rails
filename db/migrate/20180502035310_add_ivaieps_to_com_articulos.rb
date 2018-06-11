class AddIvaiepsToComArticulos < ActiveRecord::Migration[5.1]
  def change
    add_column :com_articulos, :iva, :decimal, precision: 5, scale: 2, default: 0.0
    add_column :com_articulos, :ieps, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
