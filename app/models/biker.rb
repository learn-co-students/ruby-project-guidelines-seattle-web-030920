class Biker < ActiveRecord::Base
    has_many :bikes
    has_many :trips    

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end