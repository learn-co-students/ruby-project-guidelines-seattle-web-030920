class Commute< ActiveRecord::Base
    belongs_to :user
    has_many :commute_stops
    has_many :stops, through: :commute_stops

    def self.shortest(user)
      array=Commute.all.select{|commute| commute.user == user}
      array.min_by{|commute| commute.distance}
    end
    def self.longest(user)
      array=Commute.all.select{|commute| commute.user == user}
      array.max_by{|commute| commute.distance}
    end

    def distance
      loc1 =[UserStop.find_by_id(self.user_stop_1_id).stop.stop_lat, UserStop.find_by_id(self.user_stop_1_id).stop.stop_lon]
      loc2 = [UserStop.find_by_id(self.user_stop_2_id).stop.stop_lat, UserStop.find_by_id(self.user_stop_1_id).stop.stop_lon]

       rad_per_deg = Math::PI/180  # PI / 180
       rkm = 6371                  # Earth radius in kilometers
       rm = rkm * 1000             # Radius in meters
     
       dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
       dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
     
       lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
       lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
     
       a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
       c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
     
       (rm * c*0.000621371).round(2) # Delta in miles from meters
     end
end