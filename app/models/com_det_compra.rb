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

  enum tipo_comprobante: MovMovimiento.tipo_comprobantes.keys


  before_create :actualiza_inventario
  before_destroy :elimina_del_inventario

  def calcular_descuento
    cvalor = cantidad * precio
    cvalor * descuento / 100
  end

  def calcular_total
    cvalor = cantidad * precio
    cdescuento = calcular_descuento
    cvalor - cdescuento
  end

  # actualiza el inventario en caso de ser un nuevo registro
  def actualiza_inventario
    if inventariar
      if new_record?
        inventario = com_articulo
            .com_inventario
            .where(emp_locacion: emp_locacion).first

        inventario.stock += cantidad
        inventario.save
      end
    end
  end

  # al borrar un detalle de compra, esta actualiza su valor en el
  # inventario
  def elimina_del_inventario
    if inventariar
      inventario = com_articulo
           .com_inventario
           .where(emp_locacion: emp_locacion).first

      inventario.stock -= cantidad
      if inventario.stock < 0 then inventario.stock = 0 end # valida que no tenga numeros negativos
      inventario.save
    end
  end
end
