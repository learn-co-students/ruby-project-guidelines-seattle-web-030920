class LoginMenu < Menu    
    def initialize()        
        @menu = <<-LOGIN_MENU
        ********  Login  **********       
        Please enter your account name with no spaces.
        
        !b - previous menu
        ***************************       
        LOGIN_MENU
        
        @input = nil    
        @my_menu_name = MenuHelpers.Login           
        @menu_to_return_to = @my_menu_name        
    end

    def input=(input)
        data_valid = false;
        account = nil
        if(input == "!b")
            @menu_to_return_to = MenuHelpers.Main
            successful_selection("(Cancled action) Returning to main menu")  
            @input = input
            return
        end

        if(!input.include?" ")            
            account = Biker.all.find_by(account_name: input)
            if(account != nil)       
                data_valid = true
            else
                data_valid = false
            end            
        end

        if(!data_valid)
            bad_selection("\nUnable to create account. Please try again\n")                                               
        else                        
            @input = "input"        
            successful_selection("Successfully logged in.")                     
            selection_result_output            
            if(account)                                       
                @menu_to_return_to = UserMenu.new(account).menu_routine
                output_formatting("")
                @sleep_time = 0
            end
        end
    end

    

    def menu_routine()     
        #puts Biker.all.find_by(account_name: "balancepanic").first_name                                
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "Account name")            
            self.input=gets.chomp    
            selection_result_output                                
        end         
        @menu_to_return_to       
    end
end