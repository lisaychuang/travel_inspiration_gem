require 'nokogiri'
require 'open-uri'

module TravelInspiration
    class Theme
        attr_accessor :name, :url
        @@themes = []

        def initialize #theme
            @@themes << self
        end
        
        def self.all
            @@themes
        end

        # def self.scrape_themes
        #     themes_list = []
        #     doc = Nokogiri::HTML(open("https://www.lonelyplanet.com/"))
        #     themes = doc.search('div.slick-track a.slick-slide') #selects carousel slides
        #     themes.each_with_index{|theme, index|
        #         if index < 12 then
        #             new_theme = TravelInspiration::Theme.new #create theme instance
        #             new_theme.name = theme.css("p").text     #assign theme name
        #             new_theme.url = theme.attr("href")       #assign theme url for destination #scraping
        #             themes_list[index] = new_theme
        #         end
        #     }
        #     themes_list
        # end

        def self.url_for_theme_name(theme_name)
            "https://www.lonelyplanet.com/#{theme_name.downcase.gsub!(/[\s,]+/,"-")}/"
        end
    end
end