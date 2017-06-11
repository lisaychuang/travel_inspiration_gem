require_relative 'themes.rb'

module TravelInspiration
    class CLI
        def call
            list_themes
        end

        def list_themes
            puts "Hello! Which travel inspiration will you like to explore for your next trip?"
            TravelInspiration::Theme.list_theme_names
        end

        def menu
            input = nil
            while input != "exit" 
                puts "Please select a theme from 1 - 12"
                input = gets.strip.to_i
                
            end

        end

        def goodbye
            put "Farewell, traveler! May the wind take you somewhere new!"
        end
    end
end

puts TravelInspiration::CLI.new.call