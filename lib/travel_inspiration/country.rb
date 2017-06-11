require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative 'themes.rb'
require_relative 'destinations.rb'

module TravelInspiration
    class Country
        attr_accessor :high_season, :low_season, :best_visit_season, :details
        def self.country_info(input)
            
            #scrape_season
            seasonality = self.scrape.season(input)
            #country info
        end

        #scrape best time to visit
        def self.scrape_season(input)
            weather_details = TravelInspiration::Country.new #Creates new Country object

            url = TravelInspiration::Country.get_url(input) #get country's url from user_input in CLI.rb
            doc = Nokogiri::HTML(open(url))
            
            seasonality_url = doc.search("#survival-guide ul li:nth-child(2) a").attr("href").text #get country weather url
            weather_pg = Nokogiri::HTML(open(seasonality_url))
            
            #get high, low, and best time to visit information
            weather_details.high_season = weather_pg.search("div.card--page__content p:nth-child(1)").text
            weather_details.best_visit_season = weather_pg.search("div.card--page__content p:nth-child(3)").first.text
            weather_details.low_season = weather_pg.search("div.card--page__content p:nth-child(5)").first.text
            
            weather_details
        end
        

        #Using user_input, get country URL to scrape information 
        def self.get_url(user_input)
            url = TravelInspiration::Destination.scrape_destinations(user_input-1)[user_input-1].url
            url
        end


    end
end

puts "Hello"
puts TravelInspiration::Country.scrape_season(1)