require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  @@pokemon_entry = []
  @@pokemon_collect = []
  :name, :type, :entry, :weight, :height, :generation, :stats, :evolution, :gender
  def scrape_page(pokemon_url)
    page = Nokogiri::HTML(open(pokemon_url))
    
  end
  
  # def generation
  #   self.get_page.css(".post")
  # end
  
  # def make_courses
  #   self.get_courses.each do |post|
  #     course = Course.new
  #     course.title = post.css("h2").text
  #     course.schedule = post.css(".date").text
  #     course.description = post.css("p").text
  #   end
  # end
  
  # def print_courses
  #   self.make_courses
  #   Course.all.each do |course|
  #     if course.title
  #       puts "Title: #{course.title}"
  #       puts "  Schedule: #{course.schedule}"
  #       puts "  Description: #{course.description}"
  #     end
  #   end
  # end
end