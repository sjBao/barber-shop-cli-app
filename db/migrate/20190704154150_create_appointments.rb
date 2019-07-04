class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :barber, foreign_key: true
      t.references :client, foreign_key: true
      t.string :notes

      t.datetime :time_slot
    end
  end
end
