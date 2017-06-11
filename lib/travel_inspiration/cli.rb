require_relative 'themes.rb'
require_relative 'destinations.rb'

module TravelInspiration
    class CLI
        def call
            list_themes
            menu
            goodbye
        end

        def list_themes
            puts "Hello! Which travel inspiration will you like to explore for your next trip?"
            puts "Please select a theme from 1 - 12"
            puts TravelInspiration::Theme.list_theme_names
            puts "----------------------" #horizontal divider
        end

        def menu
            input = nil
            while input != "exit"
                puts "Please select a theme from 1 - 12"
                input = gets.strip.to_i

                if input > 0 && input < 13
                    puts "----------------------" #horizontal divider

                    theme = TravelInspiration::Theme.list_theme_names[input-1]
                    puts "Here are the top 6 destinations for #{theme}"
                    puts TravelInspiration::Destination.list_destination_names(input-1)

                    puts "Which destination will you like to explore? Enter 1 - 6"
                    input = gets.strip.to_i
                else
                    puts "That selection is not valid. Try again, or type exit."
                end
                
            end

        end

        def goodbye
            puts "Farewell, traveler! May the wind take you somewhere new!"
        end
    end
end

puts TravelInspiration::CLI.new.call