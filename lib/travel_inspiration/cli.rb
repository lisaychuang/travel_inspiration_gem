require_relative 'themes.rb'

module TravelInspiration
    class CLI
        def call
            list_themes
        end

        def list_themes
            puts "Hello! What travel inspiration will you like to explore for your next trip?"
            TravelInspiration::Theme.list_theme_names
        end

        def menu
        end

        def goodbye
            put "Farewell, traveler! May the wind take you somewhere new!"
        end
    end
end

puts TravelInspiration::CLI.new.call