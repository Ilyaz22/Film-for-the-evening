class Film
  attr_reader :name, :year, :director

  def initialize(name, year, director)
    @name = name
    @director = director
    @year = year
  end

  def to_s
    "#{director} - #{name} (#{year})"
  end
end
