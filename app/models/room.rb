class Room < ActiveRecord::Base
has_many :work_orders
has_many :employees, through: :work_orders

end