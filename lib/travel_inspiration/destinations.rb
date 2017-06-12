require 'nokogiri'
require 'open-uri'

module TravelInspiration
    class Destination
        attr_accessor :name, :continent, :url
        
        def self.list_destination_names(theme_name)
            self.scrape_destinations(theme_name)
        end

        #scrape data using URL
        def self.scrape_destinations(theme_name)
            list = []

            url = TravelInspiration::Theme.url_for_theme_name(theme_name)
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
    end
end