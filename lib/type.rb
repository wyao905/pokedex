class Type
  attr_accessor :name
  attr_reader :weakness, :strong_against, :pokemon
  
  TYPE_ORDER = ["Normal", "Fighting", "Flying", "Poison", "Ground", "Rock",
                "Bug", "Ghost", "Steel", "Fire", "Water", "Grass",
                "Electric", "Psychic", "Ice", "Dragon", "Dark", "Fairy"]
  
  @pokemon = []
  @weakness = []
  @strong_against = []
  @@all = []
  
  def initialize(name)
    @name = name
  end
  
  def find(name)
  end
  
  def show_weakness
    list = Hash.new
    i = 0
    while i < 18 do
      if weakness[i] == "2×"
        if i == 0
          
      	1×	½×
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