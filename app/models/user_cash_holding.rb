class UserCashHolding < ActiveRecord::Base
belongs_to :user
belongs_to :bank_account

end