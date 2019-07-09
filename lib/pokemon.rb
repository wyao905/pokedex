# require "pokedex/version"
require 'pry'

class Pokemon
  attr_accessor :name,
                :number,
                :category,
                :types,       #can have 1 or 2
                :entry,       #pokedex entry description from first game
                :weight,      #returns a float in lbs
                :height,      #returns a float in inches
                :stats,       #hash of 6 stats {:hp, :attack, :defense, :special_atk, :special_def, :speed}
                :evolution,   #only scrape for after, pre-evo will be retroactively added from previous form
                :gender       #ratio split m/f
  
  @@all = []
  
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
    
  def self.all
    @@all
  end
  
  def self.find_by_name(poke_name)
    self.all.detect{|pokemon| pokemon.name == poke_name}
  end
  
  def find_by_num(poke_num)
    self.all.detect{|pokemon| pokemon.number == poke_num}
  end

  def self.create(info_hash)
    new_pokemon = self.new(info_hash)
    self.all << new_pokemon
  end
  
  def self.list_alpha # will try to list in three separate lines, need to lookup how to work with white spaces"
    alpha_list = []
    all.each {|pokemon| alpha_list << pokemon.name}
    i = 1
    # binding.pry
    while i <= all.size do
      puts "#{alpha_list[i - 1]}"
      i += 1
    end
  end
  
  def self.list_num
    number_list = {} # does not need to be sorted, can just call keys in order to access values
    all.each {|pokemon| number_list[pokemon.number] = pokemon.name}
    puts "List of Pokémon in numerical order:"
    i = 1
    while i <= all.size do
      puts "#{i}. #{number_list[i]}" # will try to list in three separate lines, need to lookup how to work with whitespaces to organize list better (total 151 pokemon need to be listed)
      i += 1
    end
  end
end