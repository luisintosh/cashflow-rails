class MovMovimiento < ApplicationRecord
  belongs_to :emp_clasificacion
  belongs_to :emp_cuentab
  belongs_to :emp_proveedor, required: false
  belongs_to :emp_cliente, required: false
  belongs_to :emp_locacion

  validates_presence_of :hoja, :fecha, :ciclo, :emp_clasificacion_id, :emp_cuentab_id, :concepto,
                        :emp_locacion_id, :subtotal, :iva, :ieps, :total
  validate :total_correcto
  validate :resta_demas

  enum tipo_comprobante: ['Factura', 'Ticket', 'Remisión', 'Nota', 'Otro']

  enum tipo_movimiento: [:egreso, :ingreso]

  SINGULAR = 'Movimiento'
  PLURAL = 'Movimientos'

  def title
    "#{fecha} #{concepto}"
  end

  # Identifica si los valores de subtotal, iva e ieps, son igual al total
  def total_correcto
    suma = subtotal + iva + ieps
    unless suma == total
      errors.add(:total, 'La sumatoria del subtotal, IVA e IEPS, no concuerda')
    end
  end

  # Revisa que el movimiento no afecte con numeros negativos a la cuenta
  def resta_demas
    if emp_cuentab.saldo_actual < total and tipo_movimiento == 'egreso'
      errors.add(:emp_cuentab, 'Saldo insuficiente')
    end
  end

  # Genera los posibles valores para la propiedad ciclos
  def self.lista_ciclos
    time_now = Time.now.year
    time_last = time_now - 5
    ciclos = []
    (time_last..time_now).to_a.each do |i|
      ciclos.append "#{i}-A"
      ciclos.append "#{i}-B"
    end
    ciclos.reverse
  end

  # Si existe un registro anterior, busca asignar este valor al nuevo registro
  def calcula_consecutivos
    if new_record?
      lastRecord = MovMovimiento.last
      if lastRecord
        self.hoja = lastRecord.hoja
        #self.ciclo = lastRecord.ciclo
      end
    end
  end

  # Obtiene las clasificaciones segun el tipo de movimiento
  def clasificaciones_fil
    EmpClasificacion.whereType tipo_movimiento
  end

  # Obtiene el titulo de la clasificacion, en caso de tener una
  def emp_clasificacion_val
    if emp_clasificacion_id?
      emp_clasificacion.title
    end
  end

  # Obtiene el titulo de la persona en caso de tenerla
  def emp_destinatario_val
    if egreso?
      if emp_proveedor_id?
        emp_proveedor.title
      end
    elsif ingreso?
      if emp_cliente_id?
        emp_cliente.title
      end
    end
  end

  def self.filters(params)
    scope = self.all.joins(:emp_clasificacion, :emp_cuentab, :emp_locacion)
    unless params[:search].blank?
      scope = scope.where('LOWER(concepto) ILIKE ?', "%#{params[:search]}%".downcase)
    end
    unless params[:f_hoja].blank?
      scope = scope.where('LOWER(hoja) = ?', params[:f_hoja].downcase)
    end
    unless params[:f_fecha_desde].blank?
      scope = scope.where('created_at > ?', params[:f_fecha_desde])
    end
    unless params[:f_fecha_hasta].blank?
      scope = scope.where('created_at < ?', params[:f_fecha_hasta])
    end
    unless params[:f_ciclo].blank?
      scope = scope.where('ciclo = ?', params[:f_ciclo])
    end
    unless params[:f_clasificacion].blank?
      scope = scope.where('emp_clasificacion_id = ?', params[:f_clasificacion])
    end
    unless params[:f_cuenta].blank?
      scope = scope.where('emp_cuentab_id = ?', params[:f_cuenta])
    end
    unless params[:f_proveedor].blank?
      scope = scope.where('emp_proveedor_id = ?', params[:f_proveedor])
    end
    unless params[:f_cliente].blank?
      scope = scope.where('emp_cliente_id = ?', params[:f_cliente])
    end
    unless params[:f_locacion].blank?
      scope = scope.where('emp_locacion_id = ?', params[:f_locacion])
    end
    unless params[:f_factura].blank?
      scope = scope.where('LOWER(factura) = ?', params[:f_hoja].downcase)
    end
    unless params[:f_comprobante].blank?
      scope = scope.where('LOWER(comprobante) = ?', params[:f_comprobante].downcase)
    end
    unless params[:f_tipo_comprobante].blank?
      scope = scope.where('tipo_comprobante = ?', params[:f_tipo_comprobante])
    end
    unless params[:f_total].blank?
      scope = scope.where('total = ?', params[:f_total])
    end

    scope
  end
end
