class AddUpgradeColToUsers < ActiveRecord::Migration[5.2]

    def change 
        add_column :users,:upgrade,:boolean
    end

end