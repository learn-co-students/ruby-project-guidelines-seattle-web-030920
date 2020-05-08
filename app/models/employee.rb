class Employee < ApplicationRecord
has_many :work_orders
has_many :rooms, through: :work_orders

validates :name, presence: true

end