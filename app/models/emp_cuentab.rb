class EmpCuentab < ApplicationRecord
  has_many :mov_movimientos

  SINGULAR = 'Cuenta'
  PLURAL = 'Cuentas de banco'

  enum moneda: [:MXN, :USD, :EUR]

  validates_presence_of :nombre, :moneda, :saldo

  def title
    "#{nombre} #{moneda}"
  end

  def ingresos
    mov_movimientos.where(tipo_movimiento: 'ingreso').sum(:total)
  end

  def egresos
    mov_movimientos.where(tipo_movimiento: 'egreso').sum(:total)
  end

  def saldo_actual
    saldo + ingresos - egresos
  end

  def self.cuentas_array(tipo)
    EmpCuentab.where(moneda: tipo).map(){|r| [r.title, r.id]}
  end
end
