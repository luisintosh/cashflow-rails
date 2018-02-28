json.extract! emp_cliente, :id, :nombre, :apellidos, :saldo, :saldo_max, :emp_perfil_id, :created_at, :updated_at
json.url emp_cliente_url(emp_cliente, format: :json)
