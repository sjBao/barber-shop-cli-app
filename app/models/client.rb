class Client < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  has_many :barbers, through: :appointments
end