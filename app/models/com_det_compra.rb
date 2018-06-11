class ComDetCompra < ApplicationRecord
  belongs_to :com_compra
  belongs_to :com_articulo
  belongs_to :emp_locacion

  validates :cantidad, numericality: {greater_than: 0}
  validates :precio, numericality: {greater_than: 0}
  validates :descuento, numericality: {greater_than_or_equal_to: 0}
  validates :iva, numericality: {greater_than_or_equal_to: 0}
  validates :ieps, numericality: {greater_than_or_equal_to: 0}

  enum moneda: [:MXN, :USD, :EUR]

  def calcular_costo
    csubtotal = cantidad * precio
    civa = iva * csubtotal
    cieps = ieps * csubtotal

    csubtotal + civa + cieps
  end

  def calcular_descuento
    cvalor = cantidad * precio
    cvalor * descuento / 100
  end

  def calcular_total
    cvalor = cantidad * precio
    cdescuento = cvalor * descuento / 100
    csubtotal = cvalor - cdescuento
    civa = iva * csubtotal
    cieps = ieps * csubtotal

    csubtotal + civa + cieps
  end
end
