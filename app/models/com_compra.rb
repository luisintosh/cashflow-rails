class ComCompra < ApplicationRecord
  belongs_to :emp_clasificacion
  belongs_to :emp_proveedor

  has_many :com_det_compra, dependent: :destroy
  has_many :com_pagos, dependent: :destroy

  SINGULAR = 'Compra'
  PLURAL = 'Compras'

  enum estado: [:pendiente, :pagado, :cancelado]

  validates :descuento, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :com_det_compra, reject_if: :all_blank, allow_destroy: true

  def title
    t = "#{fecha} - #{emp_proveedor.title}"
    unless factura.empty?
      t += ", factura: #{factura}"
    end
    t
  end

  # hace una suma de los valores de precio, descuento, subtotal, iva, ieps y total
  def suma_valores
    resultados = {}

    # totales: moneda => 0:precio, 1:cantidad, 2:descuento, 3:iva, 4:ieps, 5: total elementos
    totales2 = com_det_compra
                  .group(:moneda)
                  .pluck('moneda', 'SUM(precio)', 'SUM(cantidad)', 'SUM(descuento)', 'SUM(iva)', 'SUM(ieps), COUNT(id)')
                  .map{ |e| [e[0], e[1...7]] }.to_h

    # totales: moneda => 0:valor, 1:descuentos, 2:subtotal, 3:iva, 4:ieps
    totales = com_det_compra
                  .group(:moneda)
                  .pluck('moneda',
                         'SUM(precio * cantidad)', # 0:valor
                         'SUM((precio * cantidad) * (descuento / 100))', # 1:descuentos
                         "SUM( (((precio * cantidad) * (descuento / 100)) * (#{descuento} / 100)) )", # 2:descuento gral
                         "SUM( (precio * cantidad) - ((precio * cantidad) * (descuento / 100)) - ((precio * cantidad) * (#{descuento} / 100)) )", # 3:subtotal
                         'SUM( ((precio * cantidad) - ((precio * cantidad) * (descuento / 100))) * (iva / 100) )', # 4:iva
                         'SUM( ((precio * cantidad) - ((precio * cantidad) * (descuento / 100))) * (ieps / 100) )') # 5:ieps
                  .map{ |e| [e[0], e[1...6]] }.to_h

    # revisa todas las monedas
    EmpCuentab.monedas.each do |moneda, id_moneda|
      resultados[moneda] = {
          valor: 0.0,
          descuento: 0.0,
          desc_general: 0.0,
          subtotal: 0.0,
          iva: 0.0,
          ieps: 0.0,
          total: 0.0,
      }
      
      com_det_compra.where(moneda: moneda).each do |cdc|
        valor = cdc.precio * cdc.cantidad
        desc_cdc = valor * (cdc.descuento / 100)
        subtotal_temp = valor - desc_cdc
        desc_gral = subtotal_temp * (descuento / 100)
        subtotal = valor - desc_cdc - desc_gral
        iva = subtotal * (cdc.iva / 100)
        ieps = subtotal * (cdc.ieps / 100)
        total = subtotal + iva + ieps

        resultados[moneda][:valor] += valor
        resultados[moneda][:descuento] += desc_cdc
        resultados[moneda][:desc_general] += desc_gral
        resultados[moneda][:subtotal] += subtotal
        resultados[moneda][:iva] += iva
        resultados[moneda][:ieps] += ieps
        resultados[moneda][:total] += total
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
