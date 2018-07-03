class ComInventario < ApplicationRecord
  belongs_to :com_articulo
  belongs_to :emp_locacion

  SINGULAR = 'Inventario'
  PLURAL = 'Inventarios'

  validates :stock, numericality: {greater_than_or_equal_to: 0}
  validates :stock_min, numericality: {greater_than_or_equal_to: 0}

  def title
    "#{com_articulo.nombre}: #{stock}"
  end
end
