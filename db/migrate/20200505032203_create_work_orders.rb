class CreateWorkOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :work_orders do |t|
      t.integer :employee_id
      t.integer :room_id
      t.boolean :active
      t.string :details
    end
  end
end
