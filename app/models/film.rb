class Film < ActiveRecord::Base
    has_many :locations
    has_many :characters
    has_many :species, through: :characters

    def print_film
        puts " * Title: #{self.title}"
        puts " * Description: #{self.description}"
        puts " * Director: #{self.director}"
        puts " * Producer: #{self.producer}"
        puts " * Release-Date: #{self.release_date}"
    end

    def print_films_by_director
        Film.where("director = ?", self.director).each { |film| puts film.title }
    end

    def print_films_by_producer
        Film.where("producer = ?", self.producer).each { |film| puts film.title }
    end

    def self.most_characters
        Film.all.max_by { |film| film.characters.count }
    end
end
