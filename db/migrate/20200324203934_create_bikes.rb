class CreateBikes < ActiveRecord::Migration[5.0]
  def change
    create_table :bikes do |t|
      t.string :bike_name
      t.integer :biker_id
      t.string :bike_type
      t.integer :manufacturer
      t.boolean :stolen
    end
  end
end
