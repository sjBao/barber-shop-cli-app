class Client < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  has_many :barbers, through: :appointments

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end