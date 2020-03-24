class Character < ActiveRecord::Base
    belongs_to :film
    belongs_to :species
end
