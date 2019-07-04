class CLI
  PROMPT = TTY::Prompt.new

  def login_menu
    
  end

  def main_menu
    
  end

  def self.start
    cli = self.new
    cli.welcome_message
  end

  def welcome_message
    puts "Welcome to 12 Pell"
    sleep 0.5
    puts "Come get this 🔥 Cut"
  end
end