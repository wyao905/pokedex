require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_list
    list = []
    page = Nokogiri::HTML(open("https://www.serebii.net/pokemon/gen1pokemon.shtml"))
    entry = page.css("table.dextable td.fooinfo")
    ind = 2
    i = 0
    wile i < Pokemon.all.size do
      list << entry[ind].css("a").text
      ind += 11
      i += 1
    end
    list
  end
  
  def self.scrape_page(pokemon_url) #scrapes the necessary pokedex info to be displayed for a single pokemon only
    page = Nokogiri::HTML(open(pokemon_url))
    
    test_type = page.css("table.roundy td.roundy table.roundy table a span b")
    if test_type[1] != "Unknown"
      types = [test_type[0].text.strip, test_type[1].text.strip]
    else
      types = test_type[0].text.strip
    end
    
    height = page.css("#bodyContent #mw-content-text table.roundy")[9].text.strip.split("\n")
    height.delete("")
    height.shift(2)
    weight = page.css("#bodyContent #mw-content-text table.roundy")[10].text.strip.split("\n")
    weight.delete("")
    weight.shift(2)
    
    scraped_stats = page.css("#contentbox #bodyContent #mw-content-text table div").text.split(/\D/).reject(&:empty?)
    stats = {:HP => scraped_stats[0],
             :Attack => scraped_stats[1],
             :Defense => scraped_stats[2],
             :Special_Attack => scraped_stats[3],
             :Special_Defense => scraped_stats[4],
             :Speed => scraped_stats[5]}
    
    pokemon_entry_hash = {:name => page.css(".roundy big b").text.strip,
                          :number => "25",
                          :category => page.css("table.roundy table.roundy td.roundy table a span").text.strip,
                          :types => types,
                          :entry => page.css("table.roundy table.roundy td.roundybottom table.roundy td.roundy").first.text.strip,
                          :weight => weight,
                          :height => height,
                          :stats => stats,
                          :evolution => "yes",
                          :gender => page.css("#bodyContent #mw-content-text table.roundy")[5].text.strip.split("\n").pop().strip}
  end
end