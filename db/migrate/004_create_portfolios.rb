class CreatePortfolios < ActiveRecord::Migration[5.2]

    def change
        create_table :portfolios do |t|

            t.integer :user_id
            t.integer :stock_id
            t.integer :quantity
            #equity is quantity*current price
            t.float :equity 

            t.timestamps
        end
    end
end