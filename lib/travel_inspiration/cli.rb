require 'pry'
require_relative 'themes.rb'
require_relative 'destinations.rb'
require_relative 'country.rb'
require 'colorize'

module TravelInspiration
    class CLI
        
        def start
            list_themes
            select_theme
            goodbye
        end

        def list_themes
            puts "Hello! Which travel inspiration will you like to explore for your next trip?".green.bold
            puts "\nPlease select a theme from 1 - 12".blue.bold
            puts  TravelInspiration::Theme.list_theme_names
            puts "--------------------------------------------".black.on_white #horizontal divider
        end

        def select_theme
            input = nil
            while input != "exit"
                input = gets.strip.to_i

                if input > 0 && input < 13
                    puts "--------------------------------------------".black.on_white #horizontal divider
                    theme = TravelInspiration::Theme.list_theme_names[input-1].strip
                    puts "Here are the top 6 destinations for #{theme.upcase}\n".green.bold
                    list_destinations(input)
                else
                    puts "That selection is not valid. Please select a theme from 1 - 12, or type exit."
                end
            end
        end

        def list_destinations(destination_choice)
            puts "Please select a destination from 1 - 6".blue.bold
            country_arr = TravelInspiration::Destination.list_destination_names(destination_choice-1)

            puts country_arr.map.with_index{|d, index|
                "\t#{index+1}. #{d.name}, #{d.continent}"
                }
            puts "--------------------------------------------".black.on_white #horizontal divider
            select_country(destination_choice, country_arr)
        end

        def select_country(destination_choice, country_arr)
            country_choice = nil
            while country_choice != "exit"
                country_choice = gets.strip.to_i

                if country_choice > 0 && country_choice < 7
                    puts "--------------------------------------------".black.on_white #horizontal divider
                  
                    #select country = array[country_choice]
                    chosen_country = country_arr[country_choice-1].name.upcase

                    puts "Here's some information about #{chosen_country}, and the best time to travel there!".green.bold
                    country_details(chosen_country)
                else
                    puts "That selection is not valid. Please select a country from 1-6, or type exit."
                end
            end
        end

        def country_details(chosen_country)
            puts TravelInspiration::Country.country_info(chosen_country)
        
        end
        

        def goodbye
            puts "Farewell, traveler! May the wind take you somewhere new!"
        end
    end
end

puts TravelInspiration::CLI.new.start