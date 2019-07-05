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
        puts "Invalid choice, please select again: "
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
        # Pokemon.list_alpha
        select_poke
      elsif input == 2
        # Pokemon.list_num
        select_poke
      else
        puts "Invalid choice, please select again."
        input = gets.strip.to_i
      end
    end
    puts "What would you like to do?"
    start
  end
  
  def select_poke
    selected_poke = nil
    puts "Please enter the name of the Pokémon you wish to look up or choose from menu to go back."
    menu_message(3)
    input = gets.strip
    while input.to_i != 1 && input.to_i != 2 && selected_poke = nil do
      # selected_poke = Pokemon.find_by_name(input.downcase)
      while selected_poke == nil do
        puts "Could not find the Pokémon. Please try again or choose from menu to go back."
        menu_message(3)
        input = gets.strip.downcase
      end
    end
    
    puts "displaying info"
    # Pokemon.display(selected_poke)
    menu_message(4)
    
    if input.to_i == 1
      list(input.to_i)
    elsif input.to_i == 2
      puts "What would you like to do?"
      start
    end
  end
  
  def find(input)
    puts "Choose find by name, pokédex number, or by type."
    menu_message(input)
    input = gets.strip.to_i
    
  end
  
  def menu_message(input = "default")
    if input == 1
      puts "-----------------------------------"
      puts "Menu: 1. List in alphabetical order"
      puts "      2. List in numerical order"
      puts "      3. Back"
      puts "-----------------------------------"
    elsif input == 2
      puts "----------------------------------"
      puts "Menu: Name | Number | Type | Back"
      puts "----------------------------------"
    elsif input == 3
      puts "-------------"
      puts "Menu: 1. Back"
      puts "      2. Main"
      puts "-------------"
    elsif input == 4
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
