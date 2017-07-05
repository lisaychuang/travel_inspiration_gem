require_relative 'themes.rb'
require_relative 'destinations.rb'
require_relative 'country.rb'
require 'colorize'
require 'readline'

module TravelInspiration
    class CLI
        
        def start
            TravelInspiration::ThemeScraper.scrape_themes
            list_themes
        end

        def list_themes
            puts "Hello! Which travel inspiration will you like to explore for your next trip?".green.bold
            puts "\nPlease select a theme from 1 - 12".blue.bold
            
            theme_arr = TravelInspiration::Theme.all
            puts  theme_arr.map.with_index{|theme, index|
                "\t#{index+1}. #{theme.name}"
            }
            puts "--------------------------------------------".black.on_white #horizontal divider
            select_theme(theme_arr)
        end

        def select_theme(theme_arr)
            input = nil

            while true # user_input != "exit"
                input = Readline.readline("Select theme 🛣 ", true).strip

                goodbye if input.downcase === "exit"
                input = input.to_i 

                # input.between?(1,12)
                if input > 0 && input < 13
                    puts "--------------------------------------------".black.on_white #horizontal divider
                    theme_name = theme_arr[input-1].name.strip
                    puts "Here are the top 6 destinations for #{theme_name.upcase}\n".green.bold
                    list_destinations(theme_name)
                else
                    puts "That selection is not valid. Please select a theme from 1 - 12, or type exit."
                end
            end
        end

        def list_destinations(theme_name)
            puts "Please select a destination from 1 - 6".blue.bold
            country_arr = TravelInspiration::Destination.list_destination_names(theme_name)

            puts country_arr.map.with_index{|d, index|
                "\t#{index+1}. #{d.name}, #{d.continent}"
                }
            puts "--------------------------------------------".black.on_white #horizontal divider
            select_country(country_arr)
        end

        def select_country(country_arr)
            user_input = nil
            while true # user_input != "exit"
                user_input = Readline.readline("Select country 🗺 ", true).strip

                goodbye if user_input.downcase === "exit"

                country_choice = user_input.to_i 

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
            country = TravelInspiration::Country.new(chosen_country)
            puts country.country_info        
        end

        def goodbye
            puts "\nFarewell, traveler! May the wind take you somewhere new!".red.on_white.bold
            exit
        end
    end
end

# puts TravelInspiration::CLI.new.start