require 'pry'

class Type
  attr_accessor :name
  attr_reader :effect, :pokemon
  
  TYPE_ORDER = ["Normal",   "Fighting", "Flying", "Poison", "Ground", "Rock",
                "Bug",      "Ghost",    "Steel",  "Fire",   "Water",  "Grass",
                "Electric", "Psychic",  "Ice",    "Dragon", "Dark",   "Fairy"]
  
  @@all = []
  
  def initialize(name)
    @name = name
    @pokemon = []
    @weakness = []
    @resist = []
    @effect = []
  end

  def show_effect
    list = Hash.new
    i = 0
    while i < 18 do
      if effect[i] == "2"
        list[Type.find(TYPE_ORDER[i])] = 2
      elsif effect[i] == "1"
        list[Type.find(TYPE_ORDER[i])] = 1
      elsif effect[i] == "0.5"
        list[Type.find(TYPE_ORDER[i])] = 0.5
      else
        list[Type.find(TYPE_ORDER[i])] = 0
      end
    end
    list
  end
  
  def list
    type_list = []
    pokemon.each{|poke| type_list << poke}
    type_list.sort_by{|poke| poke.number}
    type_list.each {|a| puts a.name}
  end
  
  def self.find(name)
    all.detect{|type| type.name.downcase == name.downcase}
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