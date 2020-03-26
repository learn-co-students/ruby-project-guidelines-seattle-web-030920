require_relative '../config/environment.rb'

def welcome
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
end

def main_menu
    puts "Please input a number for the option you would like to choose:"
    puts "1. Learn about Ghibli films"
    puts "2. Learn about Ghibli film locations"
    puts "3. Learn about Ghibli film characters"
    puts "4. Learn about Ghibli character species"
    puts "5. Learn a random fact about Ghibli films"
    puts "0. Exit the application"
    choices(gets.strip)
end

def choices(choice)
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
    Film.all.each { |film| puts film.title }
    puts "Input a film from the list you would like to learn about:"
    film = gets.strip
    film_object = Film.find_by(title: film)
    if film_object
        film_object.print_film
        film_menu(film)
    else
        puts "That input was invalid. Please try again"
        film_choice
    end
end

def film_menu(film)
end

def location_choice
    puts "Here is a list of all Ghibli film location names"
    Location.all.each { |location| puts location.name }
    puts "Input a location you would like to learn about:"
    location = gets.strip
    location_object = Location.find_by(name: location)
    if location_object
        location_object.print_location
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
end

def character_choice
    puts "Here is a list of all Ghibli film character names"
    Character.all.each { |character| puts character.name }
    puts "Input a character from the list you would like to learn about:"
    character = gets.strip
    character_object = Character.find_by(name: character)
    if character_object
        character_object.print_character
        character_menu(character)
    else
        puts "That input was invalid. Please try again"
        character_choice
    end
end

def character_menu(character)
end

def species_choice
    puts "Here is a list of all Ghibli character species"
    Species.all.each { |species| puts species.name }
    puts "Input a species from the list you would like to learn about:"
    species = gets.strip
    species_object = Species.find_by(name: species)
    if species_object
        species_object.print_species
        species_menu(species)
    else
        puts "That input was invalid. Please try again"
        species_choice
    end
end

def species_menu(species)
end

def random_fact
    facts = ["me", "myself", "and", "I"]
    puts "Input the number of facts you would like to see from 1-#{facts.length} or anything else to return to main menu"
    input = gets.strip.to_i
    binding.pry
    if input > 0 && input <= facts.length
        facts.sample(input).each { |fact| puts fact }
    end
    main_menu
end

def run
    welcome
    main_menu
end

run