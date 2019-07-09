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
    if poke_name == "NidoranF".downcase
      all[28].name
    elsif poke_name == "NidoranM".downcase
      all[31].name
    else
      all.detect{|pokemon| pokemon.name.downcase == poke_name}
    end
  end
  
  def self.find_by_num(poke_num)
    all.detect{|pokemon| pokemon.number.to_i == poke_num}
  end

  def self.create(info_hash)
    new_pokemon = self.new(info_hash)
    all << new_pokemon
  end
  
  def self.list_alpha
    sorted_list = all.sort_by {|pokemon| pokemon.name}
    i = 1
    total = all.size
    while i <= total do
      if total - i == 0
        puts sorted_list[i - 1].name
      elsif total - i == 1
        puts sorted_list[i - 1].name.ljust(20) + sorted_list[i].name
      else
        puts sorted_list[i - 1].name.ljust(20) + sorted_list[i].name.ljust(20) + sorted_list[i + 1].name
      end
      i += 3
    end
  end
  
  def self.list_num
    number_list = {}
    all.each {|pokemon| number_list[pokemon.number.to_i] = pokemon.name}
    puts "List of Pokémon in numerical order:"
    i = 1
    total = all.size
    while i <= total do
      if total - i == 0
        puts "#{i}. #{number_list[i - 1]}"
      elsif total - i == 1
        puts "#{i}. #{number_list[i - 1]}".ljust(20) + "#{i + 1}. #{number_list[i]}"
      else
        puts "#{i}. #{number_list[i - 1]}".ljust(20) + "#{i + 1}. #{number_list[i]}".ljust(20) + "#{i + 2}. #{number_list[i + 1]}"
      end
      i += 3
    end
  end
end