require_relative '../config/environment.rb'

def welcome
    spacing
    puts "Welcome to the world of Studio Ghibli!"
    puts "　　　　　　　　　　　　　　　　 ﾍ"
    puts "　　　　　　　　　　　　　　ﾍ　/ |"
    puts "　　　　　　　　　　　　　/ ｜/　|"
    puts "　　　　　　　　　    　 ﾉ　|ﾉ 　|"
    puts "　　　　　　　　　 　　 ﾐ} F′〉 ｯ┘"
    puts "　 　 　　　　　　    . -┴┴‐ミ  ﾐ._"
    puts "　 　 　　　　　　> ´　　　　　　　ミ､"
    puts "　　　　　　　　/　　　　　　　　 　 ﾐ､"
    puts "　　　　　　　 ﾉ　　p￣ヽ_　　　　 　 ﾐ､"
    puts "　　　　　 rﾍ⌒　　 `ー ′　　　　　　   ﾐ､"
    puts "　　　  ﾆ{^　　　　　　　　　　　　　   ﾐ､"
    puts "　　　　 〈､_　　　＝三二_ー--　　　　   ﾐ､"
    puts "　　　　 ∠_ 　　　　ｰ＝= 二_ｰ             ﾐ､"
    puts "　 　  ／　¨ヾ､                           ﾐ､"
    puts "　    ﾉﾍ　　　ヽ                           l"
    spacing
end

def main_menu
    puts "Please input a number for the option you would like to choose:"
    puts "1. Learn about Ghibli films"
    puts "2. Learn about Ghibli film locations"
    puts "3. Learn about Ghibli film characters"
    puts "4. Learn about Ghibli character species"
    puts "5. Learn a random fact about Ghibli films"
    puts "0. Exit the application"
    spacing
    choices
end

def spacing
    puts ""
    puts "----------------------------------------------------------------"
    puts "----------------------------------------------------------------"
    puts ""
end

def choices
    choice = gets.strip
    spacing
    if choice == "0"
    elsif choice == "1"
        film_choice
    elsif choice == "2"
        location_choice
    elsif choice == "3"
        character_choice
    elsif choice == "4"
        species_choice
    elsif choice == "5"
        random_fact
    else
        puts "That input was invalid. Please try again"
        main_menu
    end
end

def film_choice
    puts "Here is a list of all Ghibli film titles"
    puts ""
    Film.all.each { |film| puts film.title }
    puts "Input a film from the list you would like to learn about:"
    title = gets.strip
    film = Film.find_by(title: title)
    if film
        film.print_film
        film_menu(film)
    else
        puts "That input was invalid. Please try again"
        film_choice
    end
end

def film_menu(film)
    puts "Input a number for the option you would like to choose:"
    puts "1. List all the other films with the same director"
    puts "2. List all the other films with the same producer"
    puts "3. Return whether this film has the most characters"
    puts "0. Return to main menu"
    run_film_choice(film)
end

def run_film_choice(film)
    choice = gets.strip
    if choice == "0"
        main_menu
    elsif choice == "1"
        film.print_films_by_director
    elsif choice == "2"
        film.print_films_by_producer
    elsif choice == "3"
        film == Film.most_characters
    else
        puts "That input was invalid. Please try again"
        film_menu
    end
end

def location_choice
    puts "Here is a list of all Ghibli film location names"
    Location.all.each { |location| puts location.name }
    puts "Input a location you would like to learn about:"
    name = gets.strip
    location = Location.find_by(name: name)
    if location
        location.print_location
        location_menu(location)
    else
        puts "That input was invalid. Please try again"
        location_choice
    end
end

def location_menu(location)
    puts "Input a number for the option you would like to choose:"
    puts "1. List all the other locations from the same film"
    puts "2. List all the other locations that have the same terrain"
    puts "3. Return whether this location's terrain is the most common"
    puts "0. Return to main menu"
    run_location_choice(location)
end

def run_location_choice(location)
    choice = gets.strip
    if choice == "0"
        main_menu
    elsif choice == "1"
        location.print_locations_by_film
    elsif choice == "2"
        location.print_locations_by_terrain
    elsif choice == "3"
        location.terrain == Location.most_common_terrain
    else
        puts "That input was invalid. Please try again"
        location_menu
    end
end

def character_choice
    puts "Here is a list of all Ghibli film character names"
    Character.all.each { |character| puts character.name }
    puts "Input a character from the list you would like to learn about:"
    name = gets.strip
    character = Character.find_by(name: name)
    if character
        character.print_character
        character_menu(character)
    else
        puts "That input was invalid. Please try again"
        character_choice
    end
end

def character_menu(character)
    puts "Input a number for the option you would like to choose:"
    puts "1. List all the other characters from the same film"
    puts "2. List all the other characters that have the same species"
    puts "3. Return whether this character's gender is the most common"
    puts "0. Return to main menu"
    run_character_choice(character)
end

def run_character_choice(location)
    choice = gets.strip
    if choice == "0"
    elsif choice == "1"
        character.print_characters_by_film
    elsif choice == "2"
        character.print_characters_by_species
    elsif choice == "3"
        character.gender == Character.most_common_gender
    else
        puts "That input was invalid. Please try again"
        character_menu
    end
end

def species_choice
    puts "Here is a list of all Ghibli character species"
    Species.all.each { |species| puts species.name }
    puts "Input a species from the list you would like to learn about:"
    name = gets.strip
    species = Species.find_by(name: name)
    if species
        species.print_species
        species_menu(species)
    else
        puts "That input was invalid. Please try again"
        species_choice
    end
end

def species_menu(species)
    puts "Input a number for the option you would like to choose:"
    puts "1. List all the other species with the same classification"
    puts "2. List all the characters with this species"
    puts "3. List all the films with characters with this species"
    puts "0. Return to main menu"
    run_species_choice(species)
end

def run_species_choice(species)
    choice = gets.strip
    if choice == "0"
    elsif choice == "1"
        species.print_species_by_classification
    elsif choice == "2"
        species.print_characters_by_species
    elsif choice == "3"
        species.print_films_by_species
    else
        puts "That input was invalid. Please try again"
        species_menu
    end
end

def random_fact
    facts = ["me", "myself", "and", "I"]
    puts "Input the number of facts you would like to see from 1-#{facts.length} or O to return to main menu"
    input = gets.strip
    binding.pry
    if input == "0"
        main_menu
    elsif input > "0" && input <= facts.length.to_s
        facts.sample(input).each { |fact| puts fact }
    else
        puts "That input was invalid. Please try again"
        random_fact
    end
end

def run
    main_menu
end
