require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  def scrape_page(pokemon_url) #scrapes the necessary pokedex info to be displayed for a single pokemon only
    page = Nokogiri::HTML(open(pokemon_url))
    
    test_type = page.css("table.roundy td.roundy table.roundy table a span b")
    if test_type[1] != "Unknown"
      types = [test_type[0].text.strip, test_type[1].text.strip]
    else
      types = test_type[0].text.strip
    end
    
    pokemon_entry_hash = {:name => page.css(".roundy big b").text.strip,
                          :category => page.css("table.roundy table.roundy td.roundy table a span").text.strip,
                          :types => types,
                          :entry => page.css("table.roundy table.roundy td.roundybottom table.roundy td.roundy").first.text.strip,
                          :weight => "some weight",
                          :height => "some height",
                          :generation => "1",
                          :stats => "weak",
                          :evolution => "yes",
                          :gender => "50/50"}
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