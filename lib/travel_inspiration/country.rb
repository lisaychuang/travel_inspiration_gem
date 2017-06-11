require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative 'themes.rb'
require_relative 'destinations.rb'

module TravelInspiration
    class Country
        attr_accessor :name, :url, :high_season, :low_season, :best_visit_season, :summary_quote, :details

        @country = TravelInspiration::Country.new #Creates new Country object

        def self.country_info(user_input)
            self.scrape_season(user_input) #set seasonality information

            self.scrape_info(user_input) #set country name, summary_quote and details
        end

        #scrape country information
        def self.scrape_info(user_input)
            @country.name = TravelInspiration::Destination.scrape_destinations(user_input-1)[user_input-1].name
            
            url = @country.url
            doc = Nokogiri::HTML(open(url))

            info_url = doc.search("#introduction article.love-letter a").attr("href").text
            info_page = Nokogiri::HTML(open(info_url))

            @country.summary_quote = info_page.search("div.copy--body p.copy--feature").text
            
            subtitles = info_page.search("div.copy--body h2").to_a
            subtitles = subtitles.map {|s| s.text}

            descriptions = info_page.search("div.copy--body p.copy--body").to_a
            descriptions = descriptions.map {|d| d.text}

            descriptions.reject!{|item|
                item.downcase.end_with?("writer")
            }

            @country.details = subtitles.map.with_index{|title, index|
                 "\n" + title.upcase + "\n" + descriptions[index] + "\n"
            }

            puts @country.details
        end


        #scrape best time to visit from Country/weather website
        def self.scrape_season(user_input)

            url = TravelInspiration::Country.get_url(user_input) #get country's url from user_input in CLI.rb
            doc = Nokogiri::HTML(open(url))
            
            seasonality_url = doc.search("#survival-guide ul li:nth-child(2) a").attr("href").text #get country weather url
            weather_pg = Nokogiri::HTML(open(seasonality_url))
            
            #get high, low, and best time to visit information
            @country.high_season = weather_pg.search("div.card--page__content p:nth-child(1)").text
            @country.best_visit_season = weather_pg.search("div.card--page__content p:nth-child(3)").first.text
            @country.low_season = weather_pg.search("div.card--page__content p:nth-child(5)").first.text
            
        end

        #Using user_input, get country URL to scrape information 
        def self.get_url(user_input)
            url = TravelInspiration::Destination.scrape_destinations(user_input-1)[user_input-1].url
            @country.url = url
        end
    end
end

puts "Hello"
puts TravelInspiration::Country.country_info(1)