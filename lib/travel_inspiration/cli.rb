require 'pry'
require_relative 'themes.rb'
require_relative 'destinations.rb'

module TravelInspiration
    class CLI
        def start
            list_themes
            select_theme
            goodbye
        end

        def list_themes
            puts "Hello! Which travel inspiration will you like to explore for your next trip?"
            puts "Please select a theme from 1 - 12"
            puts TravelInspiration::Theme.list_theme_names
            puts "----------------------" #horizontal divider
        end

        def select_theme
            input = nil
            while input != "exit"
                input = gets.strip.to_i

                if input > 0 && input < 13
                    puts "----------------------" #horizontal divider
                    theme = TravelInspiration::Theme.list_theme_names[input-1]
                    puts "Here are the top 6 destinations for #{theme.upcase}"
                    list_destinations(input)
                else
                    puts "That selection is not valid. Please select a theme from 1 - 12, or type exit."
                end
            end
        end

        def list_destinations(input)
            puts "Please select a destination from 1 - 6"
            puts TravelInspiration::Destination.list_destination_names(input-1)
            puts "----------------------" #horizontal divider
            select_country
        end

        def select_country
            input = nil
            while input != "exit"
                input = gets.strip.to_i

                if input > 0 && input < 7
                    puts "----------------------" #horizontal divider

                    country = TravelInspiration::Destination.scrape_destinations(input-1)[input-1].name
                    binding.pry
                    puts "Here's a brief introduction about #{country.upcase}, and the best time to travel there!"
                    country_details(input)
                else
                    puts "That selection is not valid. Please select a country from 1-6, or type exit."
                end
            end
        end

        def country_details(input)
            puts TravelInspiration::Destination.scrape_destinations(input-1)[input-1].url
        
        end
        

        def goodbye
            puts "Farewell, traveler! May the wind take you somewhere new!"
        end
    end
end

puts TravelInspiration::CLI.new.start