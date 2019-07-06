class ClientCli < CLI

  def login
    user_input = PROMPT.ask "What is your email?"
    @client = Client.find_by(email: user_input)

    if @client.nil?
      "We we couldn't find a user with the email: #{user_input} in our database.".slow_print
      login_menu
    else
      main_menu
    end
  end

  def new_account
    "Let's create an account:".slow_print
    params = {
      name: PROMPT.ask("What is your name?"),
      email: PROMPT.ask("What is your email?")
    }

    @client = Client.new(params)

    if @client.save
      main_menu
    else
      @client.errors.full_messages.each { |msg| msg.slow_print }
      sleep(1)
      new_account
    end
  end

  def login_menu
    PROMPT.select "" do |m|
        m.choice "Login", -> { login }
        m.choice "Create Account", -> { new_account }
        m.choice "Back", -> { App.new.welcome_menu }
      end
  end

  def main_menu
    @client.list_appointments
    PROMPT.select "What would you like to do?" do |m|
      m.choice "Book an Appointment", -> { book_appointment }
      m.choice "Update Appointment", -> { update_appointments }
      m.choice "Cancel Appointment", -> { cancel_appointments }
      m.choice "Logout", -> { login_menu }
      m.choice "Exit", -> { puts `clear`; "Stay fresh!".bold.slow_print; sleep(2) }

    end
  end

  def book_appointment
    barber = select_barber
    month = select_month if barber.present?
    day = select_day(month) if month.present?
    hour = select_hours if day.present?
    notes = PROMPT.ask("Additional notes for barber (press enter to continue).") if hour.present?

    @client.appointments.create(
      barber: barber, 
      time_slot: Time.parse("#{month.strftime('%B')}, #{day}, #{hour}"), 
      notes: notes
    ) if barber.present? && month.present? &&  day.present?

    main_menu
  end

  def update_appointments
    PROMPT.select "Which appointment do you want to update?" do |m|
      @client.appointments.order(:time_slot).each do |appt|
        m.choice appt.list_item_view, appt
      end
    end
  end

  def cancel_appointments
    PROMPT.select "Which appointment do you want to cancel?" do |m|
      @client.appointments.order(:time_slot).each do |appt|
        m.choice appt.list_item_view, -> { remove_appointment(appt) }
      end
      m.choice "back", -> { main_menu }
    end
  end

  def remove_appointment(appt)
    if confirm
      appt.destroy
      @client.reload
    end
    main_menu
  end

  def select_barber
    PROMPT.select "Who would you like to book an appointment with?" do |m|
      Barber.all.each do |barber| 
        m.choice barber.name, barber
      end
      m.choice "Back", nil
    end
  end

  def select_month
    PROMPT.select "Choose a month" do |m|
      next_3_months.each { |month| m.choice month.strftime('%B'), month }
    end
  end

  def select_day(datetime)
    if Time.now.strftime('%B') == datetime.strftime('%B')
      select_day_from_current_month
    else
      select_day_from_month(datetime)
    end
  end

  before(:login, :new_account, :book_appointment, :main_menu, :cancel_appointments) { puts `clear` }

  private

  def next_3_months
    (0..2).map { |num| Time.now + (num * 2628002.88) }
  end

  def select_day_from_current_month
    PROMPT.select "Which day?", help: "Select a day:" do |m|
      m.marker "👉"
      m. choices(Date.today.day..Date.today.end_of_month.day)
      m.choice "Back", nil
    end
  end

  def select_day_from_month(datetime)
    PROMPT.select "Which day?", help: "Select a day:" do |m|
      m.marker "👉"
      m.choices (1..datetime.end_of_month.day)
      m.choice "Back", nil
    end
  end

  def select_hours
    hours = (0..18).map { |num| parse_working_hours(num) }

    PROMPT.select "What time?", help: "Select a time:" do |m|
      m.marker "👉"
      m.choices hours
      m.choice "Back", nil
    end
  end

  def parse_working_hours(num)
    "#{11 + (num * 0.5).floor}:#{(num * 30) % 60}".to_datetime.strftime('%I:%M %p')
  end

end 