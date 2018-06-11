class ComCompra < ApplicationRecord
  belongs_to :emp_clasificacion
  belongs_to :emp_proveedor

  has_many :com_det_compra, dependent: :destroy
  has_many :com_pagos, dependent: :destroy

  SINGULAR = 'Compra'
  PLURAL = 'Compras'

  enum estado: [:pendiente, :pagado, :cancelado]

  enum tipo_comprobante: MovMovimiento.tipo_comprobantes.keys

  validates :descuento, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :com_det_compra, reject_if: :all_blank, allow_destroy: true

  def title
    t = "#{fecha} - #{emp_proveedor.title}"
    unless factura.empty?
      t += ", factura: #{factura}"
    end
    unless comprobante.empty?
      t += ", comprobante: #{comprobante}"
    end
    t
  end

  # hace una suma de los valores de precio, descuento, subtotal, iva, ieps y total
  def suma_valores
    resultados = {}

    EmpCuentab.monedas.each do |moneda, id_moneda|
      cdc = com_det_compra.where(moneda: id_moneda)

      unless resultados[moneda]
        resultados[moneda] = {
            valor: 0.0,
            descuento: 0.0,
            subtotal: 0.0,
            iva: 0.0,
            ieps: 0.0,
            total: 0.0,
        }
      end

      resultados[moneda][:valor] += (cdc.sum(:precio) * cdc.sum(:cantidad)).round(2)
      resultados[moneda][:descuento] += (resultados[moneda][:valor] * cdc.sum(:descuento) / 100).round(2)
      resultados[moneda][:subtotal] +=  (resultados[moneda][:valor] - resultados[moneda][:descuento]).round(2)
      resultados[moneda][:iva] += (resultados[moneda][:subtotal] * cdc.sum(:iva) / 100).round(2)
      resultados[moneda][:ieps] += (resultados[moneda][:subtotal] * cdc.sum(:ieps) / 100).round(2)
      resultados[moneda][:total] += (resultados[moneda][:subtotal] + resultados[moneda][:iva] + resultados[moneda][:ieps]).round(2)
    end

    resultados
  end

  # hace la suma de adeudos que se tienen de la compra
  def adeudos
    sumas = suma_valores
    resp = {cuentas_con_deuda: 0} # cuenta si alguna cuenta cuenta con deuda
    EmpCuentab.monedas.each do |moneda, id_moneda|
      total_compra = sumas[moneda][:total]
      total_deuda = total_compra - com_pagos.joins(:emp_cuentab).where('emp_cuentabs.moneda = ?', id_moneda).sum(:monto)
      resp[moneda] = {
          total: total_compra,
          deuda: total_deuda}
      if total_deuda > 0
        resp[:cuentas_con_deuda] += 1
      end
    end
    resp
  end

  # dias que han pasado desde la compra
  def dias_pasados
    Time.now.yday - created_at.yday
  end
end
