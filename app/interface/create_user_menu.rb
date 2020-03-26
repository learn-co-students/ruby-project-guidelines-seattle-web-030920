class CreateUserMenu < Menu
    attr_reader :output_statement#, :account_name, :first_name, :last_name, :address
    def initialize()
        @menu = <<-CREATE_MENU 
        ********  Create Account Menu **********       
        Please enter your account name:
            (no spaces) 
            (must be 4 characters or greater)
        !back - previous menu
        ****************************************      
        CREATE_MENU

        @input = nil
        @my_menu_name = MenuHelpers.CreateUser
        @menu_to_return_to = @my_menu_name
    end    

    def input=(input)
        data_valid = false;
        if(input == "!back")
            @menu_to_return_to = MenuHelpers.Main
            @input = input
            return
        end

        if(input.length<4)
            bad_data("Account name is too short. Must be more that 4 or more characters.")                        
            return
        end

        if(input.include?(" "))
            bad_data("Account name cannot include spaces.")                        
            return
        end

        existing_user = Biker.all.find_by(account_name: input)
        if(existing_user)
            bad_data("Account with the same name alread exist. Try a different name.")                        
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
        binding.pry
        if(new_account)
            @output_statement = "Successfully created user #{input}"
            @input = input
            @menu_to_return_to = MenuHelpers.Main
        else
            bad_data("\nUnable to create account. Please try again\n")                        
            return
        end
    end

    def bad_data(output)
        @output_statement = "\n\t#{output}\n"
        @input = nil                    
    end

    def menu_routine                   
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "New Account name")            
            self.input=gets.chomp   
            puts @output_statement
            sleep(3)
            @output_statement = "" 
        end
        @menu_to_return_to
    end
end

