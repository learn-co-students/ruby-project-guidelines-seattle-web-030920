class Location < ActiveRecord::Base
    belongs_to :film

    def print_location
        puts "Name: #{self.name}"
        puts "Terrain: #{self.terrain}"
        puts "Film: #{self.film.title}"
    end
end
