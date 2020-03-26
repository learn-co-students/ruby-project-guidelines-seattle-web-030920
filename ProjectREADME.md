
User Stories
MVP
1. a user can log in, sign up, deposit money
2. a user can search for stocks
4. a user can buy a stock
5. a user can sell a stock
6. a user can view the list of owned stocks from portfolios table
7. a user can view trade history from trades table

Stretch-goal
1. print array into table on the console
2. a user can upgrade to see stock rating and recommendation
3. a user can link to bank accounts

User has_many :trades
User has_many :stocks, through: :trades
User has_many :portfolios

Trade belongs_to :user
Trade belongs_to :stock

Stock has_many :trades
Stock has_many :users, through: :trades
Stock has_many :portfolios


Portfolio belongs_to :user
Portfolio belongs_to :stock

Stretch_goal
BankAccount belongs_to :user
User has_many :bank_accounts

???!!!question: 
1.single source of truth 
    Adding columns from related tables, good or bab? 
    in trades table, I can access @trade.user.name, but I want add that column to the trades table.
    how can I add the column from related table: I can use stock_id, but I can not use stock_current_price to pull matching price from stocks table

2. @trade.user = @user
   @trade = Trade.create(user_id: @user.id)
   Does the create method assign @user to @trade.user? Which is better?

                @trade = Trade.new
                @trade.user = @user
                @trade.stock = @stock
                @trade.quantity = shares
                @trade.buy_or_sell = "Buy"
                @trade.trading_price = @stock.current_price
                @trade.save
  can I just use @trade.create to include all of them and create at once?


3. In seeds.rb: should I pull some stocks data and save into stocks table from API?

4.  Better way to loop the choices till I choose 6

build out figures first


    