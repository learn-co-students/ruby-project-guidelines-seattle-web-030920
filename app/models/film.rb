class Film < ActiveRecord::Base
    has_many :locations
    has_many :characters
    has_many :species, through: :characters
end
