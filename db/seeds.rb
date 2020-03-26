require 'pry'
require 'rubygems'
require 'json'

manufacturer_seed_file_path = './db/bike-manufacturers.json'
biker_seed_file_path = './db/bikers.txt'
bike_seed_file_path = './db/bikes.txt'

#Empty DB
Biker.all.destroy_all
Manufacturer.all.destroy_all
Bike.all.destroy_all

##SEED Bikers
File.open(biker_seed_file_path).each do |line|
    attribute_array = line.split(";")
    Biker.new(first_name: attribute_array[0], last_name: attribute_array[1].gsub(' ',''), address: attribute_array[2].gsub("\n", "").strip, account_name: attribute_array[3].gsub("\n", "")).save
end

## SEED Manufacturers
manu_json = File.read(manufacturer_seed_file_path)
manufacturer_hash = JSON.parse(manu_json)
manufacturer_hash["manufacturers"].each{|manu| Manufacturer.new(name: manu["name"], url: manu["company_url"]).save}

##SEED Bikes
bike_types = ["Road","Mountain","Hybrid","Cruiser","Trike","Electric","Cargo","BMX","Custom"]
bike_array = []
File.open(bike_seed_file_path).each do |line|
    bike_array << line.gsub("\n", "")  
end

Biker.all.each{|biker| 
    Bike.new(bike_name: bike_array.sample(1)[0], biker_id: biker.id, bike_type: bike_types.sample(1)[0], manufacturer_id: Manufacturer.all.sample(1)[0].id, stolen: 0).save    
}

##SEED Trips
Biker.all.each{|biker|
    city_array = ["New York, NY", "Denver, CO", "Washington, DC", "Seattle, WA"]   
    #Take between 0 and 5 trips
    (rand (0..5)).times{
        start_loc = city_array.sample(1)[0]
        dest_loc = (city_array.reject{|city| city == start_loc}).sample(1)[0]
        rand_dist = (rand(1..100).to_f / 100.0) * rand(1..3000).to_f  # some random distance between 1 and 3000 miles
        ActiveRecord::Base.transaction do
            Trip.new(biker_id: biker.id, bike_id: biker.bikes[0].id, name: "A fun name", start_city: start_loc, dest_city: dest_loc, distance_miles: rand_dist, start_date: 0, end_date: 0).save
        end
        }
    biker.save
    #binding.pry
    }


puts "Done"
