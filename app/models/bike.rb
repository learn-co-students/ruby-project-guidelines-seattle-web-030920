class Bike < ActiveRecord::Base
    belongs_to :biker
    has_many :trips
    belongs_to :manufacturer

    def to_s
        bike_man = Manufacturer.all.find(self.manufacturer_id).name
        stolen_check = self.stolen ? "Yes" : "No"
        "|id:#{self.id.to_s.ljust(10)}|Bike name:#{self.bike_name.ljust(25)} |biker_id:#{self.biker_id.to_s.ljust(15)} |bike_type: #{self.bike_type.ljust(30)} |mnfct:: #{bike_man.ljust(30)} |stoken: #{stolen_check}\n"
      end
end