class CreateTrades < ActiveRecord::Migration[5.2]
    def change
        create_table :trades do |t|

            t.integer :user_id
            t.integer :stock_id
            t.integer :quantity
            t.string :buy_or_sell

            t.timestamps
        end
    end 
end