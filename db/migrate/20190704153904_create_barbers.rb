class CreateBarbers < ActiveRecord::Migration[5.2]
  def change
    create_table :barbers do |t|
      t.string :name
    end
  end
end
