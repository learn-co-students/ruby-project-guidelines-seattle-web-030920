class User < ActiveRecord::Base
    has_many :trades
    has_many :stocks, through: :trades
    has_many :portfolios
    has_one :user_cash_holding
    has_one :bank_account, through: :user_cash_holding
end