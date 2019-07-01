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
  
  def initialize(info_hash)
    info_hash.each {|key, value| self.send("#{key}=", value)}
  end
  
  def weakness
    list = []
    multiplier = Hash.new(0)
    types.each do |type|
      i = 0
      while i < Type.find(type).weak_to.size do
        list << Type.find(type).weak_to[i]
        i += 1
      end
    end
    list.each {|a| multiplier[a] += 1}
    multiplier
  end
end