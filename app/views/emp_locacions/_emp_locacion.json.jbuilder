json.extract! emp_locacion, :id, :nombre, :direccion, :created_at, :updated_at
json.url emp_locacion_url(emp_locacion, format: :json)
