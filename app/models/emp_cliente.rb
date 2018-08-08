class EmpCliente < ApplicationRecord
  belongs_to :emp_perfil, dependent: :destroy

  validates_presence_of :nombre, :apellidos, :saldo, :saldo_max
  validates :saldo, numericality: { greater_than_or_equal_to: 0 }
  validates :saldo_max, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :emp_perfil

  SINGULAR = 'Cliente'
  PLURAL = 'Clientes'

  after_initialize :create_profile, if: :new_record?

  def title
    "#{nombre} #{apellidos}"
  end

  def self.like(q)
    where('LOWER(nombre) ILIKE LOWER(:q) OR LOWER(apellidos) ILIKE LOWER(:q)', q: "%#{q}%")
  end

  # crea un nuevo perfil
  def create_profile
    build_emp_perfil
  end
end
