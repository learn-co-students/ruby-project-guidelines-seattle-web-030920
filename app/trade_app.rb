require 'pry'

class TradeApp
    attr_reader :user, :stock, :trade, :portfolio, :stock_rating,:user_cash_holding, :bank_account
    #@name a instance 
    # name a variable
    
    def run
        welcome
        #when log in, gets user information, so can use @user through all the choices to call related data. But if I did not follow choice by choice, not all 
        # method has other instance assigned data to them
     
        if log_in
        choices_string = "Tell us what do you want to do (please enter the number)? 
            1. stock search
            2. trade stocks
            4. check my portfolio
            5. check my trade history
            6. upgrade to see stock rating
            7. check my account balance
            8. transfer money
            9. link bank account
            10. check my bank account
            100. log out/ exit"

        puts choices_string
        choice = gets.chomp
        choice = choice.to_i
        while choice!=100 do
                if choice == 1
                    stock_search
                elsif choice == 2
                    trade
                elsif choice == 4
                    check_my_portfolio
                elsif choice == 5
                    my_trade_history
                elsif choice == 6
                    upgrade
                elsif choice == 7
                    check_account_balance
                elsif choice == 8
                    transfer_money
                elsif choice == 9
                    link_bank_account
                elsif choice == 10
                    check_my_bank_account
                end
            puts choices_string
            choice = gets.chomp
            choice = choice.to_i
        end
        end
    end

    def check_my_bank_account
        if check_have_bank_account
        @bank_account = @user.bank_account
        hash = @bank_account.as_json
        hash.delete("id")
        pp hash
        end
    end
    
    def check_account_balance
        if check_have_bank_account
        @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
        cash =  @user_cash_holding.cash
        puts "You have $#{cash} in your account!"
        # else
        # puts "You are not linked to a bank acount. Please link to a bank account to see your account balance."
        end
    end
    def check_have_bank_account
        have_bank_account = false
        @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
        if @user_cash_holding
            have_bank_account = true
        else
            puts "Sorry, you have to link to a bank account to perform this action."
            link_bank_account
        end
        have_bank_account
    end

    def link_bank_account
        if UserCashHolding.find_by(user_id: @user.id)
            puts "You already have a linked bank account. We only allow one bank account for now."
        else
            puts "Do you want to link to a bank account? (yes/no)"
            yes = gets.chomp
            yes = yes[0].upcase
            if yes == "Y"
                puts "Please enter the bank account_number you want to link to:"
                account = gets.chomp
                account = account.to_i
                @bank_account = BankAccount.find_by(account_number: account)

                if !UserCashHolding.find_by(bank_account_id: @bank_account.id)
                @user_cash_holding = UserCashHolding.create(user_id: @user.id, bank_account_id: @bank_account.id, cash: 0)
                #@user.save
                puts "#{account} is successfully linked to your account!"

                else
                    puts "Sorry. This bank account already linked to a user. Please link to a different bank account."
                    link_bank_account
                end
            end

        end
    end

    def transfer_money
        if check_have_bank_account
            check_account_balance
            puts "Do you want to 1.deposit or 2.withdraw? (enter a number)"
            choice = gets.chomp
            choice = choice.to_i

            if choice == 1
                deposit_money
            elsif choice == 2
                @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
                if @user_cash_holding.cash > 0
                    withdraw_money 
                else
                    puts "No money to withdraw."
                end
            end
        end
    end

    def withdraw_money
        check_account_balance
        @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
        @bank_account = @user.bank_account
        puts "Please enter an amount you want to withdraw:"
        money = gets.chomp
        money = money.to_f
        if @user_cash_holding.cash >= money
            @user_cash_holding.cash -= money
            @user_cash_holding.save

            @bank_account.account_balance +=money
            @bank_account.save
            puts "$#{money} has been withdraw from your account successfully!"
            check_account_balance
        else
            puts "Error! Please try again."
            withdraw_money
        end
        puts "Now you have $#{@user_cash_holding.cash} in your account balance. $#{@user_cash_holding.bank_account.account_balance} in you bank account"
    end
    
    def deposit_money
        @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)

        if !@user_cash_holding
            link_bank_account
            deposit_money
        else
            #choose_bank_account_for_transfer
            puts "Please enter an amount you want to deposit:"
            money = gets.chomp
            money = money.to_f
            #re-asign  @bank_account and @user_cash_holding, link_bank_account was called in if(), so nothing assigned to them in else()
            #
            @bank_account = @user.bank_account
            if @bank_account.account_balance >= money
                @bank_account.account_balance -=money
                @bank_account.save
            
                @user_cash_holding.cash += money
                @user_cash_holding.save
                puts "$#{money} has been deposit to your account successfully!"
                check_account_balance
                puts "Now you have $#{@user_cash_holding.cash} in your account balance. $#{@user_cash_holding.bank_account.account_balance} in you bank account"

            else
                puts "Sorry, you do not have enough money in your bank account. Please try again."
                    deposit_money
            end
        end
    end
    def trade
        if check_have_bank_account

        puts "Type in the ticker of the stock you want to trade:"
        stock_search
            puts "Do you want to buy or sell this stock?(buy/sell)"
            buy = gets.chomp
            buy = buy[0].upcase
                if buy == "B"
                    @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
                    if  @user_cash_holding.cash > 0
                    buy_stock
                    else
                        puts "Please transfer some money into your account. You have $#{@user_cash_holding.cash} in your account."
                    end
                elsif buy == "S"
                    if @user.portfolios
                    sell_stock
                    else
                    puts "You do not own any stocks now. You can not sell."
                    end
                end     
        end
    end

#come back to change the user's cash holdings
    def buy_stock
        puts "How many shares do you want to buy?"
            shares = gets.chomp
            shares = shares.to_i
            @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
            if @user_cash_holding.cash>= shares*@stock.current_price
                #question: include the code below gives me a row in trades table with only stock and user id 
                #and another row with full information
                #@user.stocks << @stock
                @trade = Trade.create(user_id:@user.id,stock_id: @stock.id, quantity:shares, buy_or_sell: "Buy")
            
                @user_cash_holding.cash -= shares * @stock.current_price
                @user_cash_holding.save
                    if !Portfolio.find_by(user_id:@user.id, stock_id: @stock.id)
                        @portfolio = Portfolio.create(user_id: @user.id, stock_id: @stock.id, quantity:0,equity:0) 
                    else
                    @portfolio = Portfolio.find_by(user_id: @user.id, stock_id: @stock.id)
                    end
                 @portfolio.quantity += shares
                 @portfolio.equity = @portfolio.quantity * @stock.current_price
                 @portfolio.save
                    
               puts "Trade complete! You bought #{@trade.quantity} of #{@stock.ticker} at #{@stock.current_price}. Total of #{@trade.quantity*@stock.current_price}"
               check_account_balance
            else
                can_buy = (@user_cash_holding.cash/@stock.current_price).to_i
                
                puts "You don't have enough money in your balance. You can only buy less than #{can_buy} shares."
                puts "Do you want to deposit some money into your account? (yes/no)"
                yes = gets.chomp
                yes = yes[0].upcase
                if yes == "Y"
                    deposit_money
                end
                buy_stock
            end
    end

    def sell_stock
        @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)
        #check if user own the stock
        @portfolio = Portfolio.find_by(user_id:@user.id, stock_id: @stock.id)
        if @portfolio
            puts "You have #{@portfolio.quantity} shares of this stock. How many shares do you want to sell?"
            shares = gets.chomp
            shares = shares.to_i
            if shares<=@portfolio.quantity
               
                @trade = Trade.create(user_id:@user.id,stock_id: @stock.id, quantity:shares, buy_or_sell: "Sell")

                @user_cash_holding.cash += shares * @stock.current_price
                @user_cash_holding.save

                if @portfolio.quantity == shares
                    @portfolio.delete
                else
                @portfolio.quantity -= shares
                @portfolio.equity = @portfolio.quantity * @stock.current_price
                @portfolio.save
                end

                puts "Trade complete! You sold #{@trade.quantity} of #{@stock.ticker} at #{@stock.current_price}."
                check_account_balance
            else
                puts "You only have #{@portfolio.quantity} shares of this stock. Please try again."
                sell_stock
            end
        else
            puts "You have 0 share of this stock. You cannot sell!"
        end       
     end
     def clean_and_print_aoh(aoh)
        new_aoh=[]
       i = 0
        while i < aoh.length do
        @stock = Stock.find(aoh[i]["stock_id"])
         hash = {"ticker": @stock.ticker}
         #add ticker to the top of the array
         new_aoh<<hash.merge!(aoh[i])
        i+= 1
        end
      
        clean= new_aoh.each{|hash| hash.delete("id")&&hash.delete("stock_id")&&hash.delete("user_id")&&hash.delete("created_at") }
        clean.each{|hash| puts "#{hash}\n"}
     end
    def check_my_portfolio
        if Portfolio.find_by(user_id: @user.id)
        @portfolio = @user.portfolios
        #convet to array of hashes
        portfolio_aoh = @portfolio.as_json
        clean_and_print_aoh( portfolio_aoh)
        else
            puts "You do not have a portfolio yet. Buy some stocks to build out your portfolio!"
        end
    end

    def my_trade_history
        if Trade.find_by(user_id: @user.id)
        @trade = @user.trades
        trade_aoh = @trade.as_json
        clean_and_print_aoh(trade_aoh)
        else
            puts "You do not have any trade history."
        end
    end

    def welcome
        puts "Welcome to the Trading app ~\\(^o^)/~!"
    end

    def log_in
        login = true
        puts "May I have your username? (Please enter a username)"
        username = gets.chomp
        username = username[0].upcase + username[1..-1].downcase
        if User.find_by(name:username)
            @user = User.find_by(name:username)
            puts "Welcom back!"
        else
            puts "Sorry, we can not find username. Do you want to sign up? (yes/no)"
            signup = gets.chomp
            signup = signup[0].upcase
            if signup == "Y" 
                signup = sign_up(username)
                 if !signup
                    login = false
                 end
            else
            puts "Only user can check our stock information."
            login = false
            end
        end
        login
    end

    #if can't find user, promot user to sign up
    #only 18 or older can sign up
    def sign_up(username)
        signup = true
        puts "How old are you?"
        userage = gets.chomp
        userage = userage.to_i
        if userage >= 18
            @user = User.create(name:username)
            @user.age = userage
            puts "Thank you for joining us!"
            @user.upgrade = false
            signup = true
            @user.save
        else
            puts "Sorry, you are too young to join us. Please come back when you are 18."
            signup = false
        end
        signup
    end

    #get all the info of the stock and print out
    def stock_search
        #get user input
        
         puts "Enter a stock ticker to look up a stock:"
         stock_search = gets.chomp
         stock_search = stock_search.upcase

         #find or create a new stock in local stocks table
         @stock = Stock.find_or_create_by(ticker: stock_search)
         
         #Real-time stock price, ticker, current_price
         res1 = RestClient.get("https://financialmodelingprep.com/api/v3/stock/real-time-price/#{stock_search}")
         stock_hash1 = JSON.parse(res1.body)

         @stock.current_price = stock_hash1["price"]

        #Income Statement: Revenue, EBITDA, EBITDA Margin,Gross Margin
         res2 = RestClient.get("https://financialmodelingprep.com/api/v3/financials/income-statement/#{stock_search}")
         stock_hash2 = JSON.parse(res2.body)
         stock_hash2 = stock_hash2["financials"][0]

         @stock.revenue = stock_hash2["Revenue"]
         @stock.ebitda = stock_hash2["EBITDA"]
         @stock.ebitda_margin = stock_hash2["EBITDA Margin"]
         @stock.gross_margin = stock_hash2["Gross Margin"]
        
        #Company profile: company_name, industry, exchange, market_cap
         res3 = RestClient.get("https://financialmodelingprep.com/api/v3/company/profile/#{stock_search}")
         stock_hash3 = JSON.parse(res3.body)
         stock_hash3 = stock_hash3["profile"]

         @stock.company_name = stock_hash3["companyName"]
         @stock.industry = stock_hash3["industry"]
         @stock.exchange = stock_hash3["exchange"]
         @stock.market_cap = stock_hash3["mktCap"]
         @stock.save

        #convert object to has for print out
         stock_hash = @stock.as_json
         stock_hash.delete("id")
         stock_hash.delete("created_at")
         stock_hash.each{|k,v| puts "#{k}: #{v}"}
         if @user.upgrade == true
            stock_rating(stock_search)
            else
             puts "If you upgrade. You can see the stock rating and recommendation!"
         end
        #print out all the info about the stock
     
    end
    def upgrade
        #check if user has not been upgrade 
        if @user.upgrade == false 
            #check if user has a bank account, if not, link to an bank account
            if check_have_bank_account
                puts "Upgrate only cost you $500 for lifetime. You can see both the stock rating and recommendation for buy or sell!\nEnter Yes if you want to upgrade: "
                yes = gets.chomp
                yes = yes[0].upcase
                if yes=="Y" 
                    @user_cash_holding = UserCashHolding.find_by(user_id: @user.id)

                    if @user_cash_holding.cash>= 500
                        @user_cash_holding.cash-= 500
                        @user_cash_holding.save
                        @user.upgrade = true
                        @user.save
                        puts "Congratulations! Now you are able to see the rating and recommention of a stock!\nTry look up a stock!"
                    else
                        puts "You only have #{@user_cash_holding.cash} in your account."
                        deposit_money
                        upgrade
                    end
                end
            else
                upgrade  
            end
        else
            puts "Your account already been upgraded!"
        end
    end

    def stock_rating(ticker)

         #rating, only available to upgraded users
         res4 = RestClient.get("https://financialmodelingprep.com/api/v3/company/rating/#{ticker}")
         stock_hash4 = JSON.parse(res4.body)
         stock_hash4 = stock_hash4["rating"]

         score = stock_hash4["score"]
         rating = stock_hash4["rating"]
         recommendation = stock_hash4["recommendation"]

         @stock_rating=StockRating.find_or_create_by(stock_id:@stock.id)
         @stock_rating.update(score:score, rating: rating, recommendation: recommendation)

         stock_rating_hash = @stock_rating.as_json
         stock_rating_hash.delete("id")
         stock_rating_hash.delete("stock_id")
         stock_rating_hash.delete("created_at")
         stock_rating_hash.each{|k,v| puts "#{k}: #{v}"}
    end

    
end
