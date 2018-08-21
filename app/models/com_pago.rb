class ComPago < ApplicationRecord
  belongs_to :com_compra
  belongs_to :mov_movimiento, optional: true
  belongs_to :emp_cuentab
  belongs_to :emp_locacion

  SINGULAR = 'Pago'
  PLURAL = 'Pagos'

  enum tipo_pago: ['Efectivo',
                  'Cheque nominativo',
                  'Transferencia electrónica de fondos',
                  'Tarjeta de crédito',
                  'Monedero electrónico',
                  'Dinero electrónico',
                  'Vales de despensa',
                  'Tarjeta de debito',
                  'Tarjeta de servicio',
                  'Otros']

  validates_presence_of :monto, :tipo_pago, :hoja, :concepto, :comprobante
  validates :monto, numericality: { greater_than: 0 }
  validate :valida_monto

  accepts_nested_attributes_for :mov_movimiento, reject_if: :all_blank, allow_destroy: true

  after_validation :crear_mov_movimiento, if: :new_record?
  after_create :revisa_deuda
  before_destroy :revisa_deuda

  to_param :genera_url

  def title
    concepto
  end

  # crea datos por default para el modelo
  def datos_default
    if new_record?
      lastRecord = MovMovimiento.last
      if lastRecord
        self.hoja = lastRecord.hoja
      end

      num_abonos = ComPago.where(com_compra: com_compra).count + 1
      self.concepto = "Abono #{num_abonos} a compra \"#{com_compra.title}\""
    end
  end

  # funcion para crear un movimiento
  def crear_mov_movimiento
    deudas_comp = com_compra.totales_por_comprobante
    build_mov_movimiento

    mov_movimiento.tipo_movimiento = MovMovimiento.tipo_movimientos[:egreso]
    mov_movimiento.hoja = hoja
    mov_movimiento.fecha = com_compra.fecha
    mov_movimiento.ciclo = com_compra.ciclo
    mov_movimiento.emp_clasificacion = com_compra.emp_clasificacion
    mov_movimiento.emp_cuentab = emp_cuentab
    mov_movimiento.concepto = concepto
    mov_movimiento.emp_proveedor = com_compra.emp_proveedor
    mov_movimiento.emp_locacion_id = deudas_comp[comprobante][3]
    mov_movimiento.factura = com_compra.factura
    mov_movimiento.comprobante = deudas_comp[comprobante][4]
    mov_movimiento.tipo_comprobante = deudas_comp[comprobante][5]

    # obtiene el porcentaje de pago que se hizo
    porc = monto / com_compra.suma_valores[emp_cuentab.moneda][:total]
    # calcula la cantidad en cada sección
    mov_movimiento.subtotal = com_compra.suma_valores[emp_cuentab.moneda][:subtotal] * porc
    mov_movimiento.iva = com_compra.suma_valores[emp_cuentab.moneda][:iva] * porc
    mov_movimiento.ieps = com_compra.suma_valores[emp_cuentab.moneda][:ieps] * porc
    mov_movimiento.total = monto

    #mov_movimiento.save
  end

  # revisa que el monto se pueda debitar del saldo de la cuenta
  def valida_monto
    if com_compra.adeudos[emp_cuentab.moneda][:deuda] >= monto
      unless emp_cuentab.saldo_actual > monto
        errors.add(:monto, 'Saldo insuficiente')
      end
    else
      errors.add(:monto, "Monto mayor a la deuda en #{emp_cuentab.moneda}")
    end
  end

  # revisa si el pago completa la deuda de la compra y cambia el estado de esta
  def revisa_deuda
    if com_compra.adeudos[:cuentas_con_deuda] == 0
      com_compra.pagado!
    else
      com_compra.pendiente!
    end
  end

  # busca todos los adeudos relacionados a un comprobante de pago
  def deudas_por_comprobante
    valores = com_compra.totales_por_comprobante
    valores.each do |k, v|
      valores[k] = "#{k} - $#{v[0]} #{v[1]}, #{v[2]}"
    end
    valores.invert
  end

  def genera_url
    "#{id}?com_compra_id=#{1}"
  end
end
