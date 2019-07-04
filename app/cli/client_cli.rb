class ClientCli < CLI

  def login
    user_input = PROMPT.ask "What is your email?"
    @current_user = Client.find_by(email: user_input)

    if @current_user.nil?
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
    "Let's book an appointment".slow_print
    PROMPT.select "Who would you like to book an appointment with?" do |m|
      Barber.all.each do |barber| 
        m.choice barber.name, -> {  }
      end
      m.choice "Back", -> { main_menu }
    end
  end

  before(:login, :new_account, :book_appointment) { puts `clear` }
end 