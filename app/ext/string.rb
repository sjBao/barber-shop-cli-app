class String
  PASTEL = Pastel.new

  def bold
    PASTEL.decorate(self, :bold)
  end
end