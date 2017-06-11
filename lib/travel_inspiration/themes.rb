require 'nokogiri'
require 'open-uri'
require 'pry'

module TravelInspiration
    class Theme
        attr_accessor :name, :url

        def self.list_theme_names
            themes_list = self.scrape_themes
            themes_list.map.with_index{|theme, index|
            "\t#{index+1}. #{theme.name}"
            }
        end

        def self.scrape_themes
            themes_list = []
            doc = Nokogiri::HTML(open("https://www.lonelyplanet.com/"))
            themes = doc.search('div.slick-track a.slick-slide') #selects carousel slides
            themes.each_with_index{|theme, index|
                if index < 12 then
                    new_theme = TravelInspiration::Theme.new #create theme instance
                    new_theme.name = theme.css("p").text     #assign theme name
                    new_theme.url = theme.attr("href")       #assign theme url for destination #scraping
                    themes_list[index] = new_theme
                end
            }
            themes_list
        end
    end
end

# puts 'Hello'
# newThemes = TravelInspiration::Theme.new

    # Road trips
    # Travel gear and tech
    # Travel on a budget
    # Wildlife and nature
    # Adventure travel
    # Art and culture
    # Backpacking
    # Beaches, coasts and islands
    # Family holidays
    # Festivals
    # Food and drink
    # Honeymoon and romance