class Species < ActiveRecord::Base
    has_many :characters
    has_many :films, through: :characters

    def print_species
        puts " * Name: #{self.name}"
        puts " * Classification: #{self.classification}"
    end

    def print_species_by_classification
        Species.where("classification = ?", self.classification).each { |species| puts species.name }
    end

    def print_characters_by_species
        self.characters.each { |character| puts character.name }
    end

    def print_films_by_species
        self.films.uniq.each { |film| puts film.title }
    end

    def self.order_by_most_common
        character_lists = Species.all.map { |species| species.characters }
        ordered_lists = character_lists.sort_by { |arr| arr.length }.reverse
        single_characters = ordered_lists.map { |list| list[0] }.compact
        single_characters.map { |character| character.species.name }
    end
end
