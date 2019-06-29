require "pokedex/version"

class Pokemon
  attr_reader :name,
              :category,
              :types,       #can have 1 or 2
              :entry,       #pokedex entry description from first game
              :weight,      #returns a float in lbs
              :height,      #returns a float in inches
              :generation,  #returns an integer 1 - 7
              :stats,       #hash of 6 stats {:hp, :attack, :defense, :special_atk, :special_def, :speed}
              :evolution,   #both pre and after
              :gender       #ratio split m/f
  
  @@generations = Array.new(7, [])
  
  def initialize(info_hash)
    info_hash.each {|key, value| self.send("#{key}=", value)}
    @@generations[generation - 1] << self
  end
  
  def weakness
    list = []
    types.each {|type| list << Type.find(type).weak_to}
      
    
  end
end