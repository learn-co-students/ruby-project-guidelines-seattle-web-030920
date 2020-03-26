class Bike < ActiveRecord::Base
    belongs_to :biker
    has_many :trips
    belongs_to :manufacturer

    def to_s
        bike_man = Manufacturer.all.find(self.manufacturer_id).name
        stolen_check = self.stolen ? "Yes" : "No"
        "Bike name:#{self.bike_name} | biker_id:#{self.biker_id} | bike_type: #{self.bike_type} | manufacturer: #{bike_man} | stoken: #{stolen_check}"
      end
end