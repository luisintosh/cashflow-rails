class ComInventario < ApplicationRecord
  belongs_to :com_articulo
  belongs_to :emp_locacion

  SINGULAR = 'Inventario'
  PLURAL = 'Inventarios'

  def title
    "#{com_articulo.nombre}: #{stock}"
  end
end
