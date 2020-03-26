class Character < ActiveRecord::Base
    belongs_to :film
    belongs_to :species

    def print_character
        puts " * Name: #{self.name}"
        puts " * Gender: #{self.gender}"
        puts " * Age: #{self.age}"
        puts " * Film: #{self.film.title}"
        puts " * Species: #{self.species.name}"
    end

    def print_characters_by_film
        Character.where("film_id = ?", self.film).each { |character| puts character.name }
    end

    def print_characters_by_species
        Character.where("species_id = ?", self.species).each { |character| puts character.name }
    end

    def self.most_common_gender
        genders = Character.all.map { |character| character.gender }
        genders.max_by { |gender| genders.count(gender) }
    end
end
