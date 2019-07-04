class AddIndexAndForeignKeyConstraintToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_index :appointments, :barber_id
    add_index :appointments, :client_id
  end
end
