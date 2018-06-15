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

    # totales: moneda => 0:precio, 1:cantidad, 2:descuento, 3:iva, 4:ieps
    totales = com_det_compra
                  .group(:moneda)
                  .pluck('moneda', 'SUM(precio)', 'SUM(cantidad)', 'SUM(descuento)', 'SUM(iva)', 'SUM(ieps)')
                  .map{ |e| [e[0], e[1...e.size-1]] }.to_h

    # revisa todas las monedas
    EmpCuentab.monedas.each do |moneda|
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

      if totales[moneda]
        resultados[moneda][:valor] += (totales[moneda][0] * totales[moneda][1])
        resultados[moneda][:descuento] += (resultados[moneda][:valor] * totales[moneda][2] / 100)
        resultados[moneda][:subtotal] += (resultados[moneda][:valor] - resultados[moneda][:descuento])
        resultados[moneda][:iva] += (resultados[moneda][:subtotal] * totales[moneda][3] / 100)
        resultados[moneda][:ieps] += (resultados[moneda][:subtotal] * totales[moneda][4] / 100)
        resultados[moneda][:total] += (resultados[moneda][:subtotal] + resultados[moneda][:iva] + resultados[moneda][:ieps])
      end
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
    (Time.now.yday - created_at.yday)
  end
end
