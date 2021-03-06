require_relative "../lib/pokemon.rb"
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_list
    list = Array.new
    page = Nokogiri::HTML(open("https://www.serebii.net/pokemon/gen1pokemon.shtml"))
    entry = page.css("table.dextable td.fooinfo")
    ind = 2
    i = 0
    while i < 151 do
      list << entry[ind].css("a").text
      ind += 11
      i += 1
    end
    list[28] = "NidoranF"
    list[31] = "NidoranM"
    list
  end
  
  def self.scrape_types(type_url)
    page = Nokogiri::HTML(open(type_url))
    list = page.css("#contentbox #bodyContent #mw-content-text table.roundy tr td").text.split("\n")
    list.pop
    list.delete("")
    list.map!{|a| a.strip}
    list.map!{|a| a.delete("×")}
    list.delete("???")
    list.map! do |a|
      if a == "½"
        a = "0.5"
      else
        a
      end
    end
    list
  end
  
  def self.scrape_page(pokemon_url) #scrapes the necessary pokedex info to be displayed for a single pokemon only
    page = Nokogiri::HTML(open(pokemon_url))
    
    test_type = page.css("table.roundy td.roundy table.roundy table a span b")
    if test_type[1].text.strip != "Unknown"
      types = [test_type[0].text.strip, test_type[1].text.strip]
    else
      types = test_type[0].text.strip
    end
    
    scrape_height = page.css("#bodyContent #mw-content-text table.roundy")[9].text.strip.split("\n")
    scrape_height.delete("")
    height = scrape_height.shift(2)
    scrape_weight = page.css("#bodyContent #mw-content-text table.roundy")[10].text.strip.split("\n")
    scrape_weight.delete("")
    weight = scrape_weight.shift(2)
    
    scraped_stats = page.css("#contentbox #bodyContent #mw-content-text table div").text.split(/\D/).reject(&:empty?)
    stats = {:HP => scraped_stats[0],
             :Attack => scraped_stats[1],
             :Defense => scraped_stats[2],
             :Special_Attack => scraped_stats[3],
             :Special_Defense => scraped_stats[4],
             :Speed => scraped_stats[5]}
             
    scraped_evo = 
    
    pokemon_entry_hash = {:name => page.css(".roundy big b").text.strip,
                          :number => page.css("#mw-content-text table.roundy table.roundy th.roundy big big a span").text.delete("#"),
                          :category => page.css("table.roundy table.roundy td.roundy table a span")[0].text.strip,
                          :type_names => types,
                          :entry => page.css("table.roundy table.roundy td.roundybottom table.roundy td.roundy").first.text.strip,
                          :weight => weight,
                          :height => height,
                          :stats => stats,
                          :gender => page.css("#bodyContent #mw-content-text table.roundy")[5].text.strip.split("\n").pop().strip}
  end
end