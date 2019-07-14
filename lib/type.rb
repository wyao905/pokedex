require 'pry'

class Type
  attr_accessor :name
  attr_reader :weakness, :resist, :pokemon
  
  TYPE_ORDER = ["Normal",   "Fighting", "Flying", "Poison", "Ground", "Rock",
                "Bug",      "Ghost",    "Steel",  "Fire",   "Water",  "Grass",
                "Electric", "Psychic",  "Ice",    "Dragon", "Dark",   "Fairy"]
  
  @@all = []
  
  def initialize(name)
    @name = name
    @pokemon = []
    @weakness = []
    @resist = []
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
  end
  
  def show_resistance
    list = Array.new
    i = 0
    while i < 18 do
      if resist[i] == "½×"
        list << Type.find(TYPE_ORDER[i])
      end
      i += 1
    end
    list
  end
  
  def show_immune
    list = Array.new
    i = 0
    while i < 18 do
      if resist[i] == "0×"
        list << Type.find(TYPE_ORDER[i])
      end
      i += 1
    end
    list
  end
  
  def self.find(name)
    all.detect{|type| type.name == name}
  end
  
  def self.create(name)
    new_type = self.new(name)
    all << new_type
    new_type
  end
  
  def self.all
    @@all
  end
end