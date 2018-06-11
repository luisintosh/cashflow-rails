class AddImpuestosToComDetCompras < ActiveRecord::Migration[5.1]
  def change
    add_column :com_det_compras, :iva, :decimal, precision: 5, scale: 2, default: 0.0
    add_column :com_det_compras, :ieps, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
