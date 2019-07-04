class String
  PASTEL = Pastel.new

  def bold
    PASTEL.decorate(self, :bold)
  end

  def slow_print(interval = 0.01)
    "#{self}\n".each_char do |char|
      print char
      sleep interval
    end
  end
end