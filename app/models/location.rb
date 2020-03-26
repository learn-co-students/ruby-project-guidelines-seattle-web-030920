class Location < ActiveRecord::Base
    belongs_to :film

    def print_location
        puts " * Name: #{self.name}"
        puts " * Terrain: #{self.terrain}"
        puts " * Film: #{self.film.title}"
    end

    def print_locations_by_film
        Location.where("film_id = ?", self.film).each { |location| puts location.name }
    end

    def print_locations_by_terrain
        Location.where("terrain = ?", self.terrain).each { |location| puts location.name }
    end

    def self.most_common_terrain
        terrains = Location.all.map { |location| location.terrain }
        terrains.max_by { |terrain| terrains.count(terrain) }
    end
end
