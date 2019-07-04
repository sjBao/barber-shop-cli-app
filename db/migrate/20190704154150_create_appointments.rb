class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :barber_id, :foreign_key => true
      t.integer :client_id, :foreign_key => true
      t.string :notes

      t.timestamp :time_slot
    end
  end
end
