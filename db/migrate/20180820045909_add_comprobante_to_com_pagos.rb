class AddComprobanteToComPagos < ActiveRecord::Migration[5.1]
  def change
    add_column :com_pagos, :comprobante, :string
  end
end
