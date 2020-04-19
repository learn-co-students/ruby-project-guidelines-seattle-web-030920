class Trip < ActiveRecord::Base
    belongs_to :biker
    belongs_to :bike

    def to_s
        bike_used = Bike.all.find(self.bike_id)
        biker_on_trip = Biker.all.find(self.biker_id)
        bike_man = Manufacturer.all.find(bike.manufacturer_id).name
        str_build1 = "|trip name:#{self.name.ljust(15)} |biker_name:#{biker_on_trip.full_name.ljust(20)} |bike_type: #{bike_used.bike_type.ljust(10)}"
        str_build2 = " |mnfct: #{bike_man.ljust(20)} |source: #{self.start_city.ljust(20)} |dest: #{self.dest_city.ljust(20)}" 
        str_build3 = " |dst_miles: #{self.distance_miles.round(2).to_s.ljust(10)} |strt_date: #{self.start_date.to_s.ljust(6)} |end_date: #{self.end_date}"
        "#{str_build1}#{str_build2}#{str_build3}\n"
      end
end