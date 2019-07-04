class AddIndexToBarberNameAndClientEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :barbers, :name, unique: true
    add_index :clients, :email, unique: true
  end
end
