require_relative "../lib/pokemon.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/type.rb"
require 'nokogiri'
require 'pry'

class CommandLineInterface
  BASE_PATH = "https://bulbapedia.bulbagarden.net/wiki/"

  def run
    puts "Loading..."
    
    get_pokemon_info
    input = ""
    
    puts "Hello Trainer! Welcome to the Kanto Region."
    puts "I contain information on all of the 151 Kanto Region Pokémon."
    puts "What would you like to do?"
    
    start
  end

  def get_pokemon_info
    info_hash = Scraper.scrape_page(BASE_PATH + "Pikachu_(Pokemon)") #replace pikachu with interpolation
    Pokemon.create(info_hash)
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
      else
        puts "Invalid choice, please select again."
        input = gets.strip.to_i
      end
    end
    puts "What would you like to do?"
    start
  end
  
  def select_poke(method)
    if method == "name"
      puts "Please enter the name of the Pokémon you wish to look up."
      input = gets.strip.downcase
      selected_poke = Pokemon.find_by_name(input)
      while selected_poke == nil do
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
    puts "displaying info"
    # Pokemon.display(pokemon)
    menu_message(3)
    exit!
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
        selected_type = Types.all.detect{|type| type.name == type_input}
        while selected_type == nil do
          puts "Invalid type, please try again."
          type_input = gets.strip.downcase
          selected_type = Types.all.detect{|type| type.name == type_input}
        end
        
        selected_type.list
        select_pokemon("name")
      elsif input != 4
        puts "Invalid choice, please select again."
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
      puts "      3. Find by Type"
      puts "      4. Back"
      puts "-----------------------"
    elsif input == 3
      puts "------------------"
      puts "Menu: 1. Stats"
      puts "      2. Weakness"
      puts "      3. Evolution"
      puts "      4. Previous"
      puts "      5. Next"
      puts "      6. Back"
      puts "------------------"
    else
      puts "--------------------------------"
      puts "Menu: 1. List all Pokémon"
      puts "      2. Find a specific Pokémon"
      puts "      3. Exit"
      puts "--------------------------------"
    end
  end
end
