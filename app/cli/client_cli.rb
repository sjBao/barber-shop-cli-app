class ClientCli < CLI

  def login
    user_input = PROMPT.ask "What is your email?"

    @current_user = Client.find_by(email: user_input)
    if @current_user.nil?
      "We we couldn't find #{user_input} in our database".slow_print
      "Would you like to create an account?".slow_print

      PROMPT.select "" do |m|
        m.choice "Create Account", -> { new_account }
        m.choice "Try Again", -> { login }
        m.choice "Back", -> { App.new.welcome_menu }
      end

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
      
    else
      "Sorry".slow_print
      @client.errors.full_messages.each do |msg|
        msg.slow_print
      end
    end
  end

  before(:login, :new_account) { puts `clear` }
end 