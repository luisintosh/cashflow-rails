class AddTotalToComCompras < ActiveRecord::Migration[5.1]
  def change
    add_column :com_compras, :totales, :string
    add_column :com_compras, :totales_por_comprobante, :string
  end
end
