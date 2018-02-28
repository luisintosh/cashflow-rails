class EmpClasificacion < ApplicationRecord
  SINGULAR = 'Clasificacion'
  PLURAL = 'Clasificaciones'

  validates_presence_of :nombre, :tipo_cuenta, :tipo_subcuenta, :tipo_movimiento

  enum tipo_movimiento: [:ENTRADA, :SALIDA]

  def title
    "#{nombre}, #{tipo_cuenta}, #{tipo_subcuenta}"
  end

  # Arreglo de los diferentes tipos de cuenta registrados con anterioridad
  def self.tcuentas
    all.select(:tipo_cuenta).group(:tipo_cuenta).all.collect { |i| i.tipo_cuenta }
  end
  # Arreglo de los diferentes tipos de subcuenta registrados con anterioridad
  def self.tsubcuentas
    all.select(:tipo_subcuenta).group(:tipo_subcuenta).all.collect { |i| i.tipo_subcuenta }
  end

  # Busca registros por tipo
  def self.whereType(mov_type)
    if mov_type == 'ingreso'
      where tipo_movimiento: 'ENTRADA'
    elsif mov_type == 'egreso'
      where tipo_movimiento: 'SALIDA'
    end
  end
end
