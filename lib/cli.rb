require_relative "../lib/pokemon.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/type.rb"
require 'nokogiri'
require 'pry'

class CommandLineInterface
  BASE_PATH = "https://bulbapedia.bulbagarden.net/wiki/"

  def run
    puts "Booting Up Pokédex..."
    puts "Loading Pokémon types..."
    get_type_info
    
    puts "Loading Pokémon..."
    get_pokemon_info
    
    puts "Complete"
    puts "Hello Trainer! Welcome to the Kanto Region."
    puts "I contain information on all of the 151 Kanto Region Pokémon."
    puts "What would you like to do?"
    
    start
  end
  
  def get_type_info
    i = 0
    list = Scraper.scrape_types(BASE_PATH + "Type")
    types = list.shift(18)
    while i < 18 do
      new_type = Type.create(types[i])
      j = 0
      if new_type.name == "Normal"
        while j < 18 do
          new_type.effect << list[j * 18]
          j += 1
        end
      elsif new_type.name == "Fighting"
        while j < 18 do
          new_type.effect << list[(j * 18) + 1]
          j += 1
        end
      elsif new_type.name == "Flying"
        while j < 18 do
          new_type.effect << list[(j * 18) + 2]
          j += 1
        end
      elsif new_type.name == "Poison"
        while j < 18 do
          new_type.effect << list[(j * 18) + 3]
          j += 1
        end
      elsif new_type.name == "Ground"
        while j < 18 do
          new_type.effect << list[(j * 18) + 4]
          j += 1
        end
      elsif new_type.name == "Rock"
        while j < 18 do
          new_type.effect << list[(j * 18) + 5]
          j += 1
        end
      elsif new_type.name == "Bug"
        while j < 18 do
          new_type.effect << list[(j * 18) + 6]
          j += 1
        end
      elsif new_type.name == "Ghost"
        while j < 18 do
          new_type.effect << list[(j * 18) + 7]
          j += 1
        end
      elsif new_type.name == "Steel"
        while j < 18 do
          new_type.effect << list[(j * 18) + 8]
          j += 1
        end
      elsif new_type.name == "Fire"
        while j < 18 do
          new_type.effect << list[(j * 18) + 9]
          j += 1
        end
      elsif new_type.name == "Water"
        while j < 18 do
          new_type.effect << list[(j * 18) + 10]
          j += 1
        end
      elsif new_type.name == "Grass"
        while j < 18 do
          new_type.effect << list[(j * 18) + 11]
          j += 1
        end
      elsif new_type.name == "Electric"
        while j < 18 do
          new_type.effect << list[(j * 18) + 12]
          j += 1
        end
      elsif new_type.name == "Psychic"
        while j < 18 do
          new_type.effect << list[(j * 18) + 13]
          j += 1
        end
      elsif new_type.name == "Ice"
        while j < 18 do
          new_type.effect << list[(j * 18) + 14]
          j += 1
        end
      elsif new_type.name == "Dragon"
        while j < 18 do
          new_type.effect << list[(j * 18) + 15]
          j += 1
        end
      elsif new_type.name == "Dark"
        while j < 18 do
          new_type.effect << list[(j * 18) + 16]
          j += 1
        end
      else
        while j < 18 do
          new_type.effect << list[(j * 18) + 17]
          j += 1
        end
      end
      i += 1
    end
  end

  def get_pokemon_info
    i = 0
    Scraper.scrape_list.each do |pokemon|
      if i == 121
        info_hash = Scraper.scrape_page(BASE_PATH + "Mr._Mime_(Pokemon)")
      else
        info_hash = Scraper.scrape_page(BASE_PATH + pokemon + "_(Pokemon)")
      end
      i += 1
      Pokemon.create(info_hash)
    end
  end
  
  def start
    menu_message
    input = gets.strip.to_i
    while input != 3 do
      if input == 1
        list(input)
      elsif input == 2
        find(input)
      else
        puts "Invalid choice, please select again."
        menu_message
        input = gets.strip.to_i
      end
    end
    puts "Shutting down..."
    exit!
  end
  
  def list(input)
    puts "Please choose alphabetical or numerical order."
    menu_message(input)
    input = gets.strip.to_i
    while input != 3 do
      if input == 1
        Pokemon.list_alpha
        select_poke("name")
      elsif input == 2
        Pokemon.list_num
        select_poke("number")
      elsif input != 3
        puts "Invalid choice, please select again."
        menu_message(1)
        input = gets.strip.to_i
      end
    end
    puts "What would you like to do?"
    start
  end
  
  def select_poke(method, type = nil)
    if method == "name"
      puts "Please enter the name of the Pokémon you wish to look up."
      input = gets.strip.downcase
      selected_poke = Pokemon.find_by_name(input)
      while selected_poke == nil do
        puts "Could not find the Pokémon, please try again."
        input = gets.strip.downcase
        selected_poke = Pokemon.find_by_name(input)
      end
    elsif method == "name_by_type"
      puts "Please enter the name of the Pokémon you wish to look up."
      input = gets.strip.downcase
      selected_poke = Pokemon.find_by_name(input)
      while selected_poke == nil || !type.pokemon.include?(selected_poke) do
        puts "Could not find the Pokémon, please try again."
        input = gets.strip.downcase
        selected_poke = Pokemon.find_by_name(input)
      end
    elsif method == "number"
      puts "Please enter the number of the Pokémon you wish to look up."
      input = gets.strip.to_i
      selected_poke = Pokemon.find_by_num(input)
      while selected_poke == nil do
        puts "Could not find the Pokémon, please try again."
        input = gets.strip.to_i
        selected_poke = Pokemon.find_by_num(input)
      end
    end
    display(selected_poke)
  end
    
  def display(pokemon)
    puts "No.#{pokemon.number} - #{pokemon.name}"
    puts "Category    : #{pokemon.category}"
    if pokemon.types.class == Array
      puts "Types       : #{pokemon.types[0].name} / #{pokemon.types[1].name}"
    else
      puts "Types       : #{pokemon.types.name}"
    end
    puts "Entry       : " + pokemon.entry
    puts "Weight      : #{pokemon.weight[0]} / #{pokemon.weight[1]}"
    puts "Height      : #{pokemon.height[0]} / #{pokemon.height[1]}"
    puts "Gender Ratio: #{pokemon.gender}"
    menu_message(3)
    input = gets.strip.to_i
    while input != 6 do
      if input == 1
        pokemon.stats
        menu_message(3)
        input = gets.strip.to_i
      elsif input == 2
        if pokemon.type_effect[:super].size != 0
          type_name = []
          pokemon.type_effect[:super].each{|a| type_name << a.name}
          puts "Receives super effective damage (400% damage) from: #{type_name.join(", ")}"
        end
        if pokemon.type_effect[:very].size != 0
          type_name = []
          pokemon.type_effect[:very].each{|a| type_name << a.name}
          puts "Receives very effective damage (200% damage) from: #{type_name.join(", ")}"
        end
        if pokemon.type_effect[:neutral].size != 0
          type_name = []
          pokemon.type_effect[:neutral].each{|a| type_name << a.name}
          puts "Receives neutral damage (100% damage) from: #{type_name.join(", ")}"
        end
        if pokemon.type_effect[:not].size != 0
          type_name = []
          pokemon.type_effect[:not].each{|a| type_name << a.name}
          puts "Receives not effective damage (50% damage) from: #{type_name.join(", ")}"
        end
        if pokemon.type_effect[:resist].size != 0
          type_name = []
          pokemon.type_effect[:resist].each{|a| type_name << a.name}
          puts "Receives resisted damage (25% damage) from: #{type_name.join(", ")}"
        end
        if pokemon.type_effect[:immune].size != 0
          type_name = []
          pokemon.type_effect[:immune].each{|a| type_name << a.name}
          puts "Immune (0% damage) to from: #{type_name.join(", ")}"
        end
        menu_message(3)
        input = gets.strip.to_i
      elsif input == 3
        # display evo line charmander -> charmeleon -> charizard
      elsif input == 4
        # call same function to display previous pokemon info
      elsif input == 5
        # call same function to display next pokemon info
      elsif input == 7
        puts "What would you like to do?"
        start
      elsif input != 6
        puts "Invalid choice, please try again."
        input = gets.strip.to_i
      end
    end
  end
  
  def find(input)
    puts "Choose find by name, pokédex number, or by type."
    menu_message(input)
    input = gets.strip.to_i
    while input != 4 do
      if input == 1
        select_poke("name")
      elsif input == 2
        select_poke("number")
      elsif input == 3
        puts "Please enter the type of the Pokémon you wish to look up."
        type_input = gets.strip.downcase
        selected_type = Type.find(type_input)
        while selected_type == nil do
          puts "Invalid type, please try again."
          type_input = gets.strip.downcase
          selected_type = Type.find(type_input)
        end
        if selected_type.pokemon.size > 0
          puts "Here is a list of #{selected_type.name} type Pokémon."
          selected_type.list
          select_poke("name_by_type", selected_type)
        else
          puts "There are no Pokémon of this type in Kanto, please try again."
        end
      elsif input != 4
        puts "Invalid choice, please select again."
        menu_message(2)
        input = gets.strip.to_i
      end
    end
    puts "What would you like to do?"
    start
  end
  
  def menu_message(input = "default")
    if input == 1
      puts "-----------------------------------"
      puts "Menu: 1. List in alphabetical order"
      puts "      2. List in numerical order"
      puts "      3. Back"
      puts "-----------------------------------"
    elsif input == 2
      puts "-----------------------"
      puts "Menu: 1. Find by name"
      puts "      2. Find by number"
      puts "      3. Find by type"
      puts "      4. Back"
      puts "-----------------------"
    elsif input == 3
      puts "---------------------------------------------"
      puts "Menu: 1. Stats                5. Next Pokémon"
      puts "      2. Type effectiveness   6. Back"
      puts "      3. Evolution line       7. New search"
      puts "      4. Previous Pokémon"
      puts "---------------------------------------------"
    else
      puts "--------------------------------"
      puts "Menu: 1. List all Pokémon"
      puts "      2. Find a specific Pokémon"
      puts "      3. Exit"
      puts "--------------------------------"
    end
  end
end
