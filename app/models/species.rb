class Species < ActiveRecord::Base
    has_many :characters
    has_many :films, through: :characters

    def print_species
        puts "Name: #{self.name}"
        puts "Classification: #{self.classification}"
    end
end
