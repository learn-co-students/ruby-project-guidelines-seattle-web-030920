require_relative '../config/environment.rb'
#require 'rest-client'
#require 'json'
#require 'pry'
Film.destroy_all
Species.destroy_all
Location.destroy_all
Character.destroy_all

def get_films
    film_string = RestClient.get('https://ghibliapi.herokuapp.com/films')
    film_data = JSON.parse(film_string)
    film_data.each do |film|
        Film.create(id: film["id"], title: film["title"], description: film["description"],
                director: film["director"], producer: film["producer"], release_date: film["release_date"].to_i)
    end
end

def get_species
    species_string = RestClient.get('https://ghibliapi.herokuapp.com/species')
    species_data = JSON.parse(species_string)
    species_data.each do |species|
        Species.create(id: species["id"], name: species["name"], classification: species["classification"])
    end
end

def get_locations
    location_string = RestClient.get('https://ghibliapi.herokuapp.com/locations')
    location_data = JSON.parse(location_string)
    location_data.each do |location|
        Location.create(name: location["name"], terrain: location["terrain"],
                        film_id: find_film_id(location["films"].first))
    end
end

def get_characters
    character_string = RestClient.get('https://ghibliapi.herokuapp.com/people')
    character_data = JSON.parse(character_string)
    character_data.each do |character|
        Location.create(name: character["name"], gender: character["gender"], age: character["age"].to_i,
                        film_id: 3, species_id: 3)
    end
end

def find_film_id(url)

end

get_films
get_species
