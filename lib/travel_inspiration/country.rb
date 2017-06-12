require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative 'themes.rb'
require_relative 'destinations.rb'

module TravelInspiration
    class Country
        attr_accessor :name, :url, :high_season, :low_season, :best_visit_season, :summary_quote, :details
 
        def initialize(name)
            @name = name
        end    

        def country_info
            scrape_season #set seasonality information
            scrape_info #set country name, summary_quote and details

            puts "\t#{@best_visit_season}!
                  #{@high_season}\n
                  #{@low_season}\n"
            puts "#{@summary_quote}".blue.on_yellow
            puts @details
        end

        #scrape country information
        def scrape_info
            doc = Nokogiri::HTML(open(url))

            info_url = doc.search("#introduction article.love-letter a").attr("href").text
            info_page = Nokogiri::HTML(open(info_url))

            @summary_quote = info_page.search("div.copy--body p.copy--feature").text
            
            subtitles = info_page.search("div.copy--body h2").to_a
            subtitles = subtitles.map {|s| s.text}

            descriptions = info_page.search("div.copy--body p.copy--body").to_a
            descriptions = descriptions.map {|d| d.text}

            descriptions.reject!{|item|
                item.downcase.end_with?("writer")
            }

            @details = subtitles.map.with_index{|title, index|
                 "\n" + title.upcase + "\n" + descriptions[index] + "\n"
            }
        end

        #scrape best time to visit from Country/weather website
        def scrape_season

            doc = Nokogiri::HTML(open(url))
            
            seasonality_url = doc.search("#survival-guide ul li:nth-child(2) a").attr("href").text #get country weather url
            weather_pg = Nokogiri::HTML(open(seasonality_url))
            
            #get high, low, and best time to visit information
            @high_season = weather_pg.search("div.card--page__content p:nth-child(1)").text
            @low_season = weather_pg.search("div.card--page__content p:nth-child(5)").first.text

            shoulder_season = weather_pg.search("div.card--page__content p:nth-child(3)").first.text
            @best_visit_season = "Best time to visit " + shoulder_season[16..-1]
        end

        def url
            "https://www.lonelyplanet.com/" + @name.downcase.sub(" ", "-") 
        end
    end
end

# puts TravelInspiration::Country.country_info(6)