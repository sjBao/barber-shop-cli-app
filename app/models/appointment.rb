class Appointment < ActiveRecord::Base
  belongs_to :barber
  belongs_to :client

  def list_item_view
    "#{display_time} with #{barber.name}"
  end



  def display_time
    time_slot.strftime('%B %d, %Y (%I:%M%p)')
  end
end