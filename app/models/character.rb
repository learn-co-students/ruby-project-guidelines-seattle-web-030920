class Character < ActiveRecord::Base
    belongs_to :film
    belongs_to :species

    def print_character
        puts "Name: #{self.name}"
        puts "Gender: #{self.gender}"
        puts "Age: #{self.age}"
        puts "Film: #{self.film.title}"
        puts "Species: #{self.species.name}"
    end
end
