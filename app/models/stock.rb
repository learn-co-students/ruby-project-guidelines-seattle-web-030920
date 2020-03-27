class Stock < ActiveRecord::Base
    has_many :trades
    has_many :users, through: :trades
    has_many :portfolios
    has_one :stock_rating
end