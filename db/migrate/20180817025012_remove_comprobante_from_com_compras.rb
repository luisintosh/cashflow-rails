class RemoveComprobanteFromComCompras < ActiveRecord::Migration[5.1]
  def change
    remove_column :com_compras, :comprobante, :string
    remove_column :com_compras, :tipo_comprobante, :integer
  end
end
