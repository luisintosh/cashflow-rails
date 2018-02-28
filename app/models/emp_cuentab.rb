class EmpCuentab < ApplicationRecord
  SINGULAR = 'Cuenta'
  PLURAL = 'Cuentas de banco'

  enum moneda: [:MXN, :USD, :EUR]

  validates_presence_of :nombre, :moneda, :saldo

  def title
    "#{nombre} #{moneda}"
  end
end
