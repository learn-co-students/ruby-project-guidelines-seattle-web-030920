class CreateCharacters < ActiveRecord::Migration[4.2]
    def change
        create_table :characters do |t|
            t.string :name
            t.string :gender
            t.integer :age
            t.integer :film_id
            t.integer :species_id

            t.timestamp
        end
    end
end
