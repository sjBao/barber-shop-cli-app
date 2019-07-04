class Appointment < ActiveRecord::Base
  belongs_to :barber
  belongs_to :client
end