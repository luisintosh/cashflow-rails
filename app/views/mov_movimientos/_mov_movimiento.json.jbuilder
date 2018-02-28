json.extract! mov_movimiento, :id, :tipo_movimiento, :hoja, :fecha, :ciclo, :emp_clasificacion_id, :emp_cuentab_id, :concepto, :emp_proveedor_id, :emp_cliente_id, :emp_locacion_id, :factura, :comprobante, :tipo_comprobante, :subtotal, :iva, :ieps, :total, :created_at, :updated_at
json.url mov_movimiento_url(mov_movimiento, format: :json)
