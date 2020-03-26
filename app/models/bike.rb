class Bike < ActiveRecord::Base
    belongs_to :biker
    has_many :trips
    belongs_to :manufacturer

    def to_s
        bike_man = Manufacturer.all.find(self.manufacturer_id).name
        stolen_check = self.stolen ? "Yes" : "No"
        "|Bike name:#{self.bike_name} \t|biker_id:#{self.biker_id} \t|bike_type: #{self.bike_type} \t|mnfct:: #{bike_man} \t|stoken: #{stolen_check}"
      end
end