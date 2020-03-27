class CreateFilms < ActiveRecord::Migration[4.2]
    def change
        create_table :films do |t|
            t.string :title
            t.text :description
            t.string :director
            t.string :producer
            t.integer :release_date

            t.timestamp
        end
    end
end
