require 'nokogiri'
require 'open-uri'
require 'pry'

module TravelInspiration
    class Destination
        attr_accessor :name, :continent, :url
        #Take user input 1 - 12
        #Use URL from TravelInspiration::Theme  #scrape_themes result

        def self.list_destination_names
            destination_list = self.scrape_destinations
            destination_list.map.with_index{|d, index|
            "#{index+1}. #{d.name}, #{d.continent}"
            }
        end

        #scrape data using URL

        def self.scrape_destinations
            list = []
            doc = Nokogiri::HTML(open("https://www.lonelyplanet.com/beaches-coasts-and-islands/"))
            destinations = doc.search('div.SightsList-wrap a') #selects 6 destinations 
            
            destinations.map.with_index{ |destination, index|
                new_destination = TravelInspiration::Destination.new #create destination instance
                new_destination.name = destination.css('h5').text
                new_destination.continent = destination.css('p').text
                new_destination.url = destination.attr("href")
                list[index] = new_destination
            } 
            list.sort_by! {|obj| obj.continent}
            list.sort_by! {|obj| obj.name}
            list
        end
    end
end

# puts "Hello"
# puts TravelInspiration::Destination.list_destination_names

