class Trip < ActiveRecord::Base
    belongs_to :biker
    belongs_to :bike

    def to_s
        bike_used = Bike.all.find(self.bike_id)
        biker_on_trip = Biker.all.find(self.biker_id)
        bike_man = Manufacturer.all.find(bike.manufacturer_id).name
        str_build1 = "Trip name:#{self.name} | biker_name:#{biker_on_trip.full_name} | bike_type: #{bike_used.bike_type}"
        str_build2 = " | manufacturer: #{bike_man} | start_city: #{self.start_city} | dest_city: #{self.dest_city}" 
        str_build3 = " | distance_miles: #{self.distance_miles.round(2)} | start_date: #{self.start_date} | end_date: #{self.end_date}"
        "#{str_build1}#{str_build2}#{str_build3}"
      end
end