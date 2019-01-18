class ComCompra < ApplicationRecord
  belongs_to :emp_clasificacion
  belongs_to :emp_proveedor

  has_many :com_det_compra, dependent: :destroy
  has_many :com_pagos, dependent: :destroy

  SINGULAR = 'Compra'
  PLURAL = 'Compras'

  enum estado: [:pendiente, :pagado, :cancelado]

  # almacena los totales de las compras
  serialize :totales
  serialize :totales_por_comprobante

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
    self.totales = {}
    self.totales_por_comprobante = {}

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

        # actualiza totales
        totales[moneda] = 0.0 unless totales[moneda]
        totales[moneda] += total

        # actualiza totales por comprobante
        comprobante = cdc.comprobante ? cdc.comprobante : "Sin comprobante"
        tipo_comp = cdc.tipo_comprobante ? cdc.tipo_comprobante : nil
        # total, moneda, nombre del departamento, id del departamento, comprobante, tipo de comprobante
        totales_por_comprobante[comprobante] = [0.0, nil, nil, nil, nil] unless totales_por_comprobante[comprobante]
        totales_por_comprobante[comprobante][0] += total
        totales_por_comprobante[comprobante][1] = cdc.moneda
        totales_por_comprobante[comprobante][2] = cdc.emp_locacion.nombre
        totales_por_comprobante[comprobante][3] = cdc.emp_locacion.id
        totales_por_comprobante[comprobante][4] = comprobante
        totales_por_comprobante[comprobante][5] = tipo_comp
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

  def self.suma_total_adeudos
    totales = {MXN: {total: 0.0, deuda: 0.0}, 'USD': {total: 0.0, deuda: 0.0}, 'EUR': {total: 0.0, deuda: 0.0}}
    self.pendiente.each do |item|
      totales[:MXN][:deuda] += item.adeudos['MXN'][:deuda]
      totales[:USD][:deuda] += item.adeudos['USD'][:deuda]
      totales[:EUR][:deuda] += item.adeudos['EUR'][:deuda]
    end
    totales
  end

  # marca todos los elementos como pagados
  def self.marcar_pagado(ids)
    unless ids.kind_of?(Array) then return end

    ComCompra.find(ids).each do |record|
      record.estado = ComCompra.estados['pagado']

      if record.adeudos['MXN'][:deuda] > 0
        rpago = record.com_pagos.new
        rpago
      end
    end
  end
end
