class CreateUserMenu < Menu
    attr_reader :output_statement#, :account_name, :first_name, :last_name, :address
    def initialize()
        @menu = <<-CREATE_MENU 
        ********  Create Account Menu **********       
        Please enter your account name:
            (no spaces) 
            (must be 4 characters or greater)
        !b - (GO BACK)
        ****************************************      
        CREATE_MENU

        @input = nil
        @my_menu_name = MenuHelpers.CreateUser
        @menu_to_return_to = @my_menu_name        
    end    

    def input=(input)
        data_valid = false;
        if(input == "!b")            
            successful_selection("(Canceled action) Returning to main menu")  
            @menu_to_return_to = MenuHelpers.Main
            @input = input
            return
        end

        if(input.length<4)
            bad_selection("Account name is too short. Must be more that 4 or more characters.")                        
            return
        end

        if(input.include?(" "))
            bad_selection("Account name cannot include spaces.")                        
            return
        end

        existing_user = Biker.all.find_by(account_name: input)
        if(existing_user)
            bad_selection("Account with the same name alread exist. Try a different name.")                        
            return
        end
        
        #account name is available, gather other items
        print "Input first name >"
        first_name = gets.chomp
        print "Input last name >"
        last_name = gets.chomp
        print "Input address >"
        address = gets.chomp

        
        Biker.new(account_name: input, first_name: first_name, last_name: last_name, address: address).save
        new_account = Biker.all.find_by(account_name: input)        
        if(new_account)
            successful_selection("Successfully created user #{input}")            
            @input = input
            @menu_to_return_to = MenuHelpers.Main
        else
            bad_selection("\nUnable to create account. Please try again\n")                        
            return
        end
    end

    def menu_routine                   
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "New Account name")            
            self.input=gets.chomp   
            selection_result_output
        end
        @menu_to_return_to
    end
end

