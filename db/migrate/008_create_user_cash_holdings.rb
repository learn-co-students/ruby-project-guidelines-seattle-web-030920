class CreateUserCashHoldings < ActiveRecord::Migration[5.2]
    def change
        create_table :user_cash_holdings do |t|
            t.integer :user_id
            t.integer :bank_account_id
            t.float :cash
        end
    end
end