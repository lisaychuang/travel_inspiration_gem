require 'nokogiri'
require 'open-uri'
require 'pry'

module TravelInspiration
    class Destination
        attr_accessor :name, :continent, :url
        
        def self.list_destination_names(input)
            destination_list = self.scrape_destinations(input)
            destination_list.map.with_index{|d, index|
            "#{index+1}. #{d.name}, #{d.continent}"
            }
        end

        #scrape data using URL

        def self.scrape_destinations(input)
            url = TravelInspiration::Destination.get_url(input)
            list = []
            doc = Nokogiri::HTML(open(url))
            destinations = doc.search('div.SightsList-wrap a') #selects 6 destinations 
            
            destinations.map.with_index{ |destination, index|
                new_destination = TravelInspiration::Destination.new #create destination instance
                new_destination.name = destination.css('h5').text
                new_destination.continent = destination.css('p').text
                new_destination.url = destination.attr("href")
                list[index] = new_destination
            } 
            list.sort_by! {|obj| [obj.continent, obj.name]}
            list
        end
        
        #Using user_input, get theme URL to scrape for destinations
        def self.get_url(user_input)
            url = TravelInspiration::Theme.scrape_themes[user_input].url
            url
        end

    end
end

# puts "Hello"
# puts TravelInspiration::Destination.list_destination_names

