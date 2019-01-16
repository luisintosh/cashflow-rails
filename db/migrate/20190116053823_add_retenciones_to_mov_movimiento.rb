class AddRetencionesToMovMovimiento < ActiveRecord::Migration[5.1]
  def change
    add_column :mov_movimientos, :retencion_iva, :decimal, precision: 5, scale: 2, default: 0.0
    add_column :mov_movimientos, :retencion_ieps, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
