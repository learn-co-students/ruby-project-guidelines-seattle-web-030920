class CreateBankAccounts < ActiveRecord::Migration[5.2]
    def change
        create_table :bank_accounts do |t|
            t.integer :account_number
            t.string :iban
            t.string :name
            t.string :rounting_number
            t.string :swift_bic
            t.float :account_balance
        end
    end
end