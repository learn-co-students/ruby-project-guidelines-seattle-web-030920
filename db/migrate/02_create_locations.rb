class CreateLocations < ActiveRecord::Migration[4.2]
    def change
        create_table :locations do |t|
            t.string :name
            t.string :terrain
            t.integer :film_id

            t.timestamp
        end
    end
end
