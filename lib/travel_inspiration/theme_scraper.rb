module TravelInspiration
    class ThemeScraper


        def self.scrape_themes
            doc = Nokogiri::HTML(open("https://www.lonelyplanet.com/"))
            themes = doc.search('div.slick-track a.slick-slide') #selects carousel slides
            themes.each_with_index{|theme, index|
                if index < 12 then
                    new_theme = TravelInspiration::Theme.new #create theme instance
                    new_theme.name = theme.css("p").text     #assign theme name
                    new_theme.url = theme.attr("href")       #assign theme url for destination #scraping
                end
            }
        end

    end

end