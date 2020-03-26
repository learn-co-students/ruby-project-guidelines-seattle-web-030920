class Film < ActiveRecord::Base
    has_many :locations
    has_many :characters
    has_many :species, through: :characters

    def print_film
        puts "Title: #{self.title}"
        puts "Description: #{self.description}"
        puts "Director: #{self.director}"
        puts "Producer: #{self.producer}"
        puts "Release-Date: #{self.release_date}"
    end
end
