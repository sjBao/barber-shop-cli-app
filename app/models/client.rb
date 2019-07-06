class Client < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  has_many :barbers, through: :appointments

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def list_appointments
    "Here are your appointments:".slow_print(0)
    puts "--------------------------"
    appointments.order(:time_slot).each do |appointment|
      "• #{appointment.display_time.bold} with #{appointment.barber&.name.bold}".slow_print(0)
      "  #{appointment.notes} #{appointment.notes && "\n"}".slow_print(0)
    end
    puts "--------------------------"
  end

end