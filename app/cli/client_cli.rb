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
    PROMPT.select "What would you like to do?" do |m|
      m.choice "Book an Appointment", -> { book_appointment }
      m.choice "View Appointment", -> {  }
      m.choice "Update Appointment", -> {  }
      m.choice "Cancel Appointment", -> {  }
      m.choice "Logout", -> { login_menu }
      m.choice "Exit", -> { "Stay fresh!".bold.slow_print; sleep(2) }

    end
  end

  def book_appointment
    barber = select_barber
    month = select_month
    day = select_day(month)
    hour = select_hours
    notes = PROMPT.ask("Additional notes for barber (press enter to continue).")

    p Time.parse("#{month}, #{day}, #{hour}")
    @client.appointments.create(barber: barber, time_slot: Time.parse("#{month.strftime('%B')}, #{day}, #{hour}"), notes: notes)
  end



  def select_barber
    PROMPT.select "Who would you like to book an appointment with?" do |m|
      Barber.all.each do |barber| 
        m.choice barber.name, barber
      end
      m.choice "Back", -> { main_menu }
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

  def select_hours
    hours = (0..18).map { |num| parse_working_hours(num) }

    PROMPT.select "What time?", help: "Select a time:" do |m|
      m.marker "👉"
      m.choices hours
    end
  end

  before(:login, :new_account, :book_appointment) { puts `clear` }

  private

  def next_3_months
    (0..2).map { |num| Time.now + (num * 2628002.88) }
  end

  def select_day_from_current_month
    PROMPT.select "Which day?", help: "Select a day:" do |m|
      m.marker "👉"
      m. choices(Date.today.day..Date.today.end_of_month.day)
    end
  end

  def select_day_from_month(datetime)
    PROMPT.select "Which day?", help: "Select a day:" do |m|
      m.marker "👉"
      m.choices (1..datetime.end_of_month.day)
    end
  end

  def parse_working_hours(num)
    "#{11 + (num * 0.5).floor}:#{(num * 30) % 60}".to_datetime.strftime('%I:%M %p')
  end



end 