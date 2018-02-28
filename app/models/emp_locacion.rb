class EmpLocacion < ApplicationRecord
  SINGULAR = 'Departamento'
  PLURAL = 'Departamentos'

  validates_presence_of :nombre, :direccion

  def title
    nombre
  end
end
