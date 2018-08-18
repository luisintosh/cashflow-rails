class AddComprobanteToComDetCompras < ActiveRecord::Migration[5.1]
  def change
    add_column :com_det_compras, :comprobante, :string
    add_column :com_det_compras, :tipo_comprobante, :integer
  end
end
