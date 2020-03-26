class CreateBikers < ActiveRecord::Migration[5.0]
  def change
    create_table :bikers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :account_name
    end
  end
end
