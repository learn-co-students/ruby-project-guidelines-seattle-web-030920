class CreateStocks < ActiveRecord::Migration[5.2]
    def change
        create_table :stocks do |t|

            t.string :ticker
            t.string :company_name
            t.string :industry
            t.string :exchange
            t.float :current_price
            t.float :revenue
            t.float :ebitda
            t.float :market_cap
            t.float :gross_margin
            t.float :ebitda_margin
            
            t.timestamps
        end
    end
end