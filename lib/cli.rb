require_relative "../lib/pokemon.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/type.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  BASE_PATH = "https://bulbapedia.bulbagarden.net/wiki/"

  def run
    make_pokemon
    add_attributes_to_students
    display_students
  end

  def make_pokemon
    info_hash = Scraper.scrape_page(BASE_PATH + "Pikachu_(Pokémon)") #replace pikachu with interpolation
    Student.create(info_hash)
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
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

end
