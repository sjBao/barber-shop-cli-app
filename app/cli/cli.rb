class CLI
  PROMPT = TTY::Prompt.new

  def confirm(message = "Are you sure?")
    PROMPT.select message do |m|
      m.choice "Yes", true
      m.choice "No", false
    end
  end

  private
  # Aspect oriented programming: puts clear before some methods
  # https://stackoverflow.com/questions/5513558/executing-code-for-every-method-call-in-a-ruby-module
  def self.before(*names)
    names.each do |name|
      m = instance_method(name)
      define_method(name) do |*args, &block|  
        yield
        m.bind(self).(*args, &block)
      end
    end
  end
end