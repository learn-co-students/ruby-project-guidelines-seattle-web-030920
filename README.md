
## User Stories
1. a user can log in, sign up
2. a user can link to a bank account and transfer money
2. a user can search for stocks
3. a user can trade (buy/sell) stocks
6. a user can view the list of owned stocks from portfolios table
7. a user can view trade history from trades table
8. a user can upgrade to see stock rating and recommendation
9. a user can check linked bank account
10. a user can check account_balance (how much cash in the user account)

## Data relationships

## User
    has_many :trades
    has_many :stocks, through: :trades
    has_many :portfolios
    has_one :user_cash_holding
    has_one :bank_account, through: :user_cash_holding

## Stock
    has_many :trades
    has_many :users, through: :trades
    has_many :portfolios
    has_one :stock_rating

## StockRating
    belongs_to :stock

## Trade
    belongs_to :user
    belongs_to :stock

## Portfolio
    belongs_to :user
    belongs_to :stock

## BankAccount
    has_one :user_cash_holding
    has_one :user, through: :user_cash_holding

UserCashHolding
    belongs_to :user
    belongs_to :bank_account

## User Guide

If this is your first time run this program. Run "rake db:seed" in console, this allows you to: 
  1. load the bank accounts data for later use, otherwise cannot connect to a bank account. 
  2. clean all the database in all tables. Start fresh and clean.
  3. If you don't want to clean the database next time you run the program, no need to run "rake db:seed" again.

Run "ruby bin/run.rb" to start the program

If you are a new user: Put in a username, age to sign up. You have to be at least 18 to sign up. 
If you already signed up before, you can start use this program.

It will give you a list of choices for you to choose. Any choice related to trade, transfer money, or upgrade the use account require you to link to a bank account first.

To link to a bank account:
    1. "command+shift+p"  -> search "SQLite: Open Database" -> "development.db"
    2. you can see "SQLITE EXPLORER" on the bottom left corner, open it. Open "bank_accounts" table.
    3. Copy a bank account number and paste in your console when it is asking for your bank account.
    4. Refresh the "SQLITE EXPLORER" every time after you run "rake db:seed" to refresh the data.
    5. Every bank account has billions of dollars to use!

If you want to exit the program, type "100" in the console to exit or log out your account.

## Fun detail: 
if you don't have enough money to buy the amount of stocks you want to buy. It will promote the amount you can buy, or promote you to deposit more money.






  
