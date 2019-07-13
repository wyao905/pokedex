class Type
  attr_accessor :name
  attr_reader :weakness, :strong_against, :pokemon
  
  @pokemon = []
  @weakness = []
  @strong_against = []
  @@all = []
  
  def initialize(name)
    @name = name
  end
  
  def show_weakness
  end
  
  def show_strong_against
  end
  
  def self.create(name)
    new_type = self.new(name)
    all << new_type
  end
  
  def self.all
    @@all
  end
end