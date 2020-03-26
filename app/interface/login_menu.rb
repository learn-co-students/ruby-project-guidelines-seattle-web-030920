class LoginMenu < Menu
    
    def initialize()        
        @menu = <<-LOGIN_MENU
        ********  Login  **********       
        Please enter your account name with no spaces.
        
        !back - previous menu
        ***************************       
        LOGIN_MENU
        
        @input = nil    
        @my_menu_name = MenuHelpers.Login           
        @menu_to_return_to = @my_menu_name
    end

    def input=(input)
        data_valid = false;
        account = nil
        if(input == "!back")
            @menu_to_return_to = MenuHelpers.Main
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
            @input = nil
            puts "Invalid data - account name must not contain spaces.  Try again"            
        else            
            @input = "!back"            
            if(account)                       
                @menu_to_return_to = UserMenu.new(account).menu_routine
            end
        end
    end
    
    def menu_routine()     
        #puts Biker.all.find_by(account_name: "balancepanic").first_name                                
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "Account name")            
            self.input=gets.chomp                        
        end         
        @menu_to_return_to       
    end
end