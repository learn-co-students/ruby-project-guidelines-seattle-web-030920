class WorkOrder < ActiveRecord::Base
belongs_to :employee
belongs_to :room

end