class EmpProveedor < ApplicationRecord
  belongs_to :emp_perfil, dependent: :destroy

  validates_presence_of :empresa, :saldo, :saldo_max
  validates :saldo, numericality: { greater_than_or_equal_to: 0 }
  validates :saldo_max, numericality: { greater_than_or_equal_to: 0 }
  validates :empresa, uniqueness: true

  accepts_nested_attributes_for :emp_perfil

  SINGULAR = 'Proveedor'
  PLURAL = 'Proveedores'

  def title
    empresa
  end

  def self.like(q)
    where('LOWER(empresa) ILIKE LOWER(:empresa)', empresa: "%#{q}%")
  end
end
