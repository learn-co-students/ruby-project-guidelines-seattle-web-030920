class Employee <ActiveRecord::Base
has_many :work_orders
has_many :rooms, through: :work_orders

end