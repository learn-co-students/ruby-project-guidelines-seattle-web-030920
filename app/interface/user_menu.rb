class UserMenu < Menu
    attr_reader :account
    def initialize(account)
        @menu = <<-USER_MENU
        ********  User Menu  **********       
        1. MY BIKES        
        5. MY TRIPS
        9. MAIN MENU - (GO BACK)
        ***************************
        USER_MENU

        @input = nil
        @account = account
        @my_menu_name = MenuHelpers.User  
        @menu_to_return_to = @my_menu_name   
    end

    def input=(input)
        data_valid = false;

        if(input.length == 1)        
            valid_choices = ["1", "5", "9"]                        
            if(valid_choices.any?(input))
                @input = input
                data_valid = true
                case input
                when "1"                                                            
                    @menu_to_return_to = BikeMenu.new(@account).menu_routine
                when "5"
                    @menu_to_return_to = TripMenu.new(@account).menu_routine
                when "9"
                    puts "MAIN MENU"
                    @menu_to_return_to = MenuHelpers.Main

                end     
            end
        else
            data_valid = false
        end

        if(data_valid)
            @input = input
        else
            @input = nil
        end 

    end

    def menu_routine()                           
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super            
            self.input=gets.chomp                 
        end  
        @menu_to_return_to      
    end

end