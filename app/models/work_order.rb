class WorkOrder < ApplicationRecord
belongs_to :employee
belongs_to :room

validates :room_id, presence: true
validates :employee_id, presence: true
end