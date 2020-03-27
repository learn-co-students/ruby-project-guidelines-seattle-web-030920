require_relative '../config/environment.rb'
Film.destroy_all
Species.destroy_all
Location.destroy_all
Character.destroy_all

def get_films
    film_string = RestClient.get('https://ghibliapi.herokuapp.com/films')
    film_data = JSON.parse(film_string)
    film_data.each do |film|
        Film.create(title: film["title"], description: film["description"], director: film["director"],
                    producer: film["producer"], release_date: film["release_date"].to_i)
    end
end

def get_species
    species_string = RestClient.get('https://ghibliapi.herokuapp.com/species')
    species_data = JSON.parse(species_string)
    species_data.each do |species|
        Species.create(name: species["name"], classification: species["classification"])
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
        Character.create(name: character["name"], gender: character["gender"], age: character["age"],
                    film_id: find_film_id(character["films"].first), species_id: find_species_id(character["species"]))
    end
end

def find_film_id(url)
    res = RestClient.get(url)
    title = JSON.parse(res)["title"]
    Film.find_by(title: title).id
end

def find_species_id(url)
    res = RestClient.get(url)
    name = JSON.parse(res)["name"]
    Species.find_by(name: name).id
end

get_films
get_species
get_locations
get_characters

puts "Done!"
