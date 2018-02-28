json.extract! emp_clasificacion, :id, :nombre, :tipo_cuenta, :tipo_subcuenta, :tipo_movimiento, :created_at, :updated_at
json.url emp_clasificacion_url(emp_clasificacion, format: :json)
