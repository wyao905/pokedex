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


    # while input != "exit" do
    #   if input == "list all"
    #     puts "How would you like to list?"
    #     menu(input)
    #   elsif input == "alphabetical" || input == "numerical"
    #     find_select = input
    #     puts "In #{input} order:"
    #     # Pokemon.list(input)
    #     menu(input)
    #   elsif input == "select"
    #     puts "Which Pokémon you would like to see?"
    #     select_input = gets.strip.downcase
    #     while Pokemon.all.include?(select_input) != true || (pokemon_select.to_i <= 0 && pokemon_select.to_i > 151) do
    #       puts "Could not find Pokémon. Please try again or go back."
    #       select_input = gets.strip.downcase
    #       if select_input == "back"
            
    #     end
    #     if select_input == "alphabetical"
    #       # Pokemon.find_by_name(pokemon_select)
    #       puts "find by name"
    #     else
    #       # Pokemon.find_by_num(pokemon_select)
    #     end
    #   elsif select_input == "main"
    #   elsif
    #     puts "Invalid choice, please select from the menu below"
    #     menu(select_input)
    #   elsif list_all_input != "back"
    #     puts "Invalid choice, please select from the menu below"
    #     menu(list_all_input)
    #   elsif input == "find"
    #       Pokemon.find
    #   elsif input == "default"
    #     input = "default"
    #     menu(input)
    #   else
    #     puts "Invalid choice, please select from the menu below."
    #     menu(input)
    #   end
    #   input = gets.strip.downcase
    # end
    puts "Shutting down..."
  end

  def get_pokemon_info
    info_hash = Scraper.scrape_page(BASE_PATH + "Pikachu_(Pokemon)") #replace pikachu with interpolation
    Pokemon.create(info_hash)
  end

  def display_pokemon_info
    
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
    start
  end
  
  def select_poke
    puts "Please enter the name of the Pokémon you wish to look up."
    input = gets.strip.downcase
    
    
  end
  
  def menu(input)
    if input == "list all"
      puts "--------------------------------------"
      puts "Menu: Alphabetical | Numerical | Back"
      puts "--------------------------------------"
    elsif input == "find"
      puts "----------------------------------"
      puts "Menu: Name | Number | Type | Back"
      puts "----------------------------------"
    elsif input == "alphabetical" || input == "numerical" || input == "type"
      puts "---------------------------"
      puts "Menu: Select | Back | Main"
      puts "---------------------------"
    elsif input == "display"
      puts "------------------------------------------------------------"
      puts "Menu: Previous | Stats | Weakness | Evolution | Next | Back"
      puts "------------------------------------------------------------"
    else
      puts "--------------------------------"
      puts "Menu: 1. List all Pokémon"
      puts "      2. Find a specific Pokémon"
      puts "      3. Exit"
      puts "--------------------------------"
    end
  end
end
