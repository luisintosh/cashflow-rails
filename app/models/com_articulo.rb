class ComArticulo < ApplicationRecord
  has_many :com_inventario, dependent: :destroy

  accepts_nested_attributes_for :com_inventario

  SINGULAR = 'Articulo'
  PLURAL = 'Articulos'

  enum moneda: [:MXN, :USD, :EUR]

  validates_presence_of :codigo, :nombre, :unidad_compra, :unidad_inventario, :cantidad_inventario
  validates :codigo, uniqueness: true
  validates :nombre, uniqueness: true

  def title
    "#{codigo} - #{nombre}"
  end

  def self.unidades
    ['Pieza', 'Elemento', 'Unidad de Servicio', 'Kilogramo', 'Gramo', 'Tarifa', 'Metro', 'Pulgada', 'Pie',
     'Yarda', 'Metro Cuadrado', 'Metro Cúbico', 'Litro', 'Galón', 'Paquete a Granel', 'Lote', 'Variedad',
     'Cabeza (Ganado)', 'Paquete', 'Caja', 'Kit', 'Bloque', 'Tonelada']
  end

  def crear_inventarios
    EmpLocacion.all.each do |locacion|
      com_inventario.build emp_locacion_id: locacion.id
    end
  end

  def total_inventario
    com_inventario.sum(:stock)
  end
end
