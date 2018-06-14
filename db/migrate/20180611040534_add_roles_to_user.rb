class AddRolesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nombre, :string
    add_column :users, :role, :integer, default: 0
  end
end
