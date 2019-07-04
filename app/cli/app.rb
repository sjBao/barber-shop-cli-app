require_relative 'cli'
class App < CLI

  def initialize
    @client_cli = ClientCli.new
  end
  
  def welcome_menu
    PROMPT.select 'Are you a client or a barber?' do |m|
      m.choice "Client", -> { @client_cli.login_menu }
      m.choice "Barber", -> {  }
      m.choice "Exit"
    end
  end
  
  def self.start
    cli = self.new
    cli.welcome_message
  end
  
  def welcome_message
    "Welcome to 12 Pell".bold.slow_print
    sleep 0.5
    "Come get this 🔥 Cut!".bold.slow_print
    sleep 0.5
    PROMPT.keypress("Press space or enter to continue", keys: [:space, :return])
    welcome_menu
  end

  before(:welcome_message, :welcome_menu) { puts `clear` }
end