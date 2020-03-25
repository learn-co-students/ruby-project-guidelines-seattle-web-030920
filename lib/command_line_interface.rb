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
    gets.strip
end

def choices
    choice = main_menu
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
        choices
    end
end

def film_choice
    puts "Here is a list of all Ghibli film titles"
    Film.all.each { |film| puts film.title }
    puts "Input a film from the list you would like to learn about:"
    film = gets.strip
    print_film(film)
    film_menu(film)
end

def print_film(film)
end

def film_menu(film)
end

def location_choice
    puts "Here is a list of all Ghibli film location names"
    Location.all.each { |location| puts location.name }
    puts "Input a location you would like to learn about:"
    location = gets.strip
    print_location(location)
    location_menu(location)
end

def print_location(location)
end

def location_menu(location)
    puts "Input a number for the option you would like to choose:"
    puts ""
end

def character_choice
    puts "Here is a list of all Ghibli film character names"
    Character.all.each { |character| puts character.name }
    puts "Input a character from the list you would like to learn about:"
    character = gets.strip
    print_character(character)
    character_menu(character)
end

def print_character(character)
end

def character_menu(character)
end

def species_choice
    puts "Here is a list of all Ghibli character species"
    Species.all.each { |species| puts species.name }
    puts "Input a species from the list you would like to learn about:"
    species = gets.strip
    print_species(species)
    species_menu(species)
end

def print_species(species)
end

def species_menu(species)
end

def random_fact
    facts = ["", "", "", "", ""]
end

def run
    welcome
    choices
end

run