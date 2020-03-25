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
    if Film.find_by(title: film)
        print_film(film)
        film_menu(film)
    else
        puts "That input was invalid. Please try again"
        film_choice
    end
end

def print_film(film)
    film_object = Film.find_by(title: film)
    puts "Title: #{film}"
    puts "Description: #{film_object.description}"
    puts "Director: #{film_object.director}"
    puts "Producer: #{film_object.producer}"
    puts "Release-Date: #{film_object.release_date}"
end

def film_menu(film)
end

def location_choice
    puts "Here is a list of all Ghibli film location names"
    Location.all.each { |location| puts location.name }
    puts "Input a location you would like to learn about:"
    location = gets.strip
    if Location.find_by(name: location)
        print_location(location)
        location_menu(location)
    else
        puts "That input was invalid. Please try again"
        location_choice
    end
end

def print_location(location)
    location_object = Location.find_by(name: location)
    puts "Name: #{location}"
    puts "Terrain: #{location_object.terrain}"
    puts "Film: #{location_object.film.title}"
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
    if Character.find_by(name: character)
        print_character(character)
        character_menu(character)
    else
        puts "That input was invalid. Please try again"
        character_choice
    end
end

def print_character(character)
    character_object = Character.find_by(name: character)
    puts "Name: #{character}"
    puts "Gender: #{character_object.gender}"
    puts "Age: #{character_object.film.title}"
    puts "Film: #{character_object.film.title}"
    puts "Species: #{character_object.species.name}"
end

def character_menu(character)
end

def species_choice
    puts "Here is a list of all Ghibli character species"
    Species.all.each { |species| puts species.name }
    puts "Input a species from the list you would like to learn about:"
    species = gets.strip
    if Species.find_by(name: species)
        print_species(species)
        species_menu(species)
    else
        puts "That input was invalid. Please try again"
        species_choice
    end
end

def print_species(species)
    species_object = Species.find_by(name: species)
    puts "Name: #{species}"
    puts "Classification: #{species_object.classification}"
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