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

    def self.director_producer
        directors = Film.all.map { |film| film.director }
        producers = Film.all.map { |film| film.producer }
        director_producers = directors & producers
        director_producers.reduce { |line, person| line + " and #{person}" }
    end

    def self.most_frequent_release_decade
        release_dates = Film.all.map { |film| film.release_date }.sort
        starting_decade = release_dates[0] / 10
        decades = []
        while starting_decade < 203
            decades << release_dates.select { |year| year / 10 == starting_decade }
            starting_decade += 1
        end
        (decades.max_by { |decade| decade.length }[0] / 10) * 10
    end

    def self.most_variety_of_species
        species_list = Film.all.max_by { |film| film.species.uniq.length }.title
    end
end
