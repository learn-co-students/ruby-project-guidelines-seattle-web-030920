class BankAccount < ActiveRecord::Base
    has_one :user_cash_holding
    has_one :user, through: :user_cash_holding
end