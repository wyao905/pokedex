require "pokedex/version"

class Pokemon
  attr_reader :name, :type, :entry, :weight, :height, :generation, :stats, :evolution, :gender
  
  def initialize(info_hash)
    info_hash.each {|key, value| self.send("#{key}=", value)}
  end
    
end