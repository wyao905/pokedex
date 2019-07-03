require_relative "../lib/pokemon.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/type.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  BASE_PATH = "https://bulbapedia.bulbagarden.net/wiki/"

  def run
    puts "Loading..."
    
    get_pokemon_info
    
    puts "Hello Trainer! Welcome to the Kanto Region."
    puts "I contain information on all of the 151 Kanto Region Pokémon."
    puts "What would you like to do?"
    puts "-------------------------"
    puts "Menu: List | Find | Exit"
    puts "-------------------------"
    input = gets.strip.downcase

    while input != "exit" do
      if input == "list"
        menu(input)
        list_input = gets.strip.downcase
        while list_input != "back" do
          if list_input == "alphabetical" || list_input == "numerical"
            Pokemon.list(list_nput)
            
          end
        end
      elsif input == "find"
          Pokemon.find
      else
        puts "Invalid choice, please select from the menu below."
        puts "-------------------------"
        puts "Menu: List | Find | Exit"
        puts "-------------------------"
        input = gets.strip.downcase
      end
    end
    puts "Shutting down..."
  end

  def get_pokemon_info
    info_hash = Scraper.scrape_page(BASE_PATH + "Pikachu_(Pokémon)") #replace pikachu with interpolation
    Pokemon.create(info_hash)
  end

  def display_pokemon_info
    
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end
  
  def menu(input)
    if input == "list"
      puts "--------------------------------------"
      puts "Menu: Alphabetical | Numerical | Back"
      puts "--------------------------------------"
    else input == ""
end
