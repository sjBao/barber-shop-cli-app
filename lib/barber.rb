class Barber < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  has_many :clients, through: :appointments
end