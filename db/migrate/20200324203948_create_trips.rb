class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer :biker_id
      t.integer :biker_id
      t.string :name
      t.string :start_city
      t.string :dest_city
      t.float :distance_miles
      t.integer :start_date
      t.integer :end_date
    end
  end
end
