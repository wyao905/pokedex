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
    
    menu(input)
    input = gets.strip.downcase

    while input != "exit" do
      if input == "list all"
        puts "How would you like to list?"
        menu(input)
        input = gets.strip.downcase
      elsif input == "alphabetical" || input == "numerical"
        puts "In alphabetical order:"
        # Pokemon.list(input)
        menu(input)
        input = gets.strip.downcase
      elsif input == "select"
        puts "Which Pokémon you would like to see?"
        input = gets.strip.downcase
        test_valid? = input
        while Pokemon.all.include?(pokemon_select) == true || (pokemon_select.to_i > 0 && pokemon_select.to_i <= 151) do
      if temp_input == "alphabetical"
        # Pokemon.find_by_name(pokemon_select)
        puts "find by name"
      elsif temp_input == "numerical"
        # Pokemon.find_by_num(pokemon_select)
      elsif select_input == "main"
      elsif
        puts "Invalid choice, please select from the menu below"
        menu(select_input)
        select_input = gets.strip.downcase
      elsif list_all_input != "back"
        puts "Invalid choice, please select from the menu below"
        menu(list_all_input)
        list_all_input = gets.strip.downcase
      elsif input == "find"
          Pokemon.find
      elsif input == "default"
        input = "default"
        menu(input)
      else
        puts "Invalid choice, please select from the menu below."
        menu(input)
        input = gets.strip.downcase
      end
    end
    puts "Shutting down..."
  end

  def get_pokemon_info
    info_hash = Scraper.scrape_page(BASE_PATH + "Pikachu_(Pokemon)") #replace pikachu with interpolation
    Pokemon.create(info_hash)
  end

  def display_pokemon_info
    
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
      puts "-----------------------------"
      puts "Menu: List All | Find | Exit"
      puts "-----------------------------"
    end
  end
end
