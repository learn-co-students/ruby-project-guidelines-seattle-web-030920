class Species < ActiveRecord::Base
    has_many :characters
    has_many :films, through: :characters
end
