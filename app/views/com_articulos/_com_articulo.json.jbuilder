json.extract! com_articulo, :id, :codigo, :nombre, :categoria, :unidad_compra, :unidad_inventario, :cantidad_inventario, :iva, :ieps, :created_at, :updated_at
json.url com_articulo_url(com_articulo, format: :json)
