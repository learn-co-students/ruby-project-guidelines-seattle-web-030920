class CreateStockRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_ratings do |t|
        t.integer :stock_id
        t.integer :score
        t.string :rating
        t.string :recommendation
    end
  end
end