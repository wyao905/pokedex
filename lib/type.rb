class Type
  attr_accessor :name
  attr_reader :weakness, :resist, :pokemon
  
  TYPE_ORDER = ["Normal",   "Fighting", "Flying", "Poison", "Ground", "Rock",
                "Bug",      "Ghost",    "Steel",  "Fire",   "Water",  "Grass",
                "Electric", "Psychic",  "Ice",    "Dragon", "Dark",   "Fairy"]
  
  @pokemon = []
  @weakness = []
  @resist = []
  @@all = []
  
  def initialize(name)
    @name = name
  end

  def show_weakness
    list = Array.new
    i = 0
    while i < 18 do
      if weakness[i] == "2×"
        list << Type.find(TYPE_ORDER[i])
      end
      i += 1
    end
    list
      	1×	½×
  end
  
  def show_resistance
    list = Array.new
    i = 0
    while i < 18 do
      if resist[i] == "×"
        list << Type.find(TYPE_ORDER[i])
      end
      i += 1
    end
    list
  end
  
  def show_immune
  end
  
  def self.find(name)
  end
  
  def self.create(name)
    new_type = self.new(name)
    all << new_type
  end
  
  def self.all
    @@all
  end
end