class MainMenu < Menu
    def initialize()
        @menu = <<-MAIN_MENU 
        ********  Main Menu **********       
        1. LOGIN
        5. CREATE NEW ACCOUNT
        7. ADMIN - *Not implemented yet
        9. EXIT APPLICATION
        **************************      
        MAIN_MENU
        
        @input = nil
        @my_menu_name = MenuHelpers.Main
        @menu_to_return_to = @my_menu_name
    end

    def input=(input)
        data_valid = false;    
        
        if(input.length == 1)
        
            valid_choices = ["1", "5", "7", "9"]                        
            if(valid_choices.any?(input))
                data_valid = true
                case input
                when "1"                                                            
                    @menu_to_return_to = LoginMenu.new.menu_routine
                when "5"
                    @menu_to_return_to = CreateUserMenu.new.menu_routine
                when "7"
                    puts "Not yet implemented"
                    puts "Admin Menu"
                when "9"
                    @menu_to_return_to = "exit"   
                    @input = "exit"                 
                end     
            end
        else
            bad_selection("Invalid selection. Please try again")                                    
        end       
    end

    def menu_routine      
        #puts Biker.all.find_by(account_name: "balancepanic").first_name         
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super         
            self.input=gets.chomp            
            selection_result_output  
        end
        puts "\n\t*****************************************************\n"
        puts "\n\tThank you for using the Biker program.  Byke for now!\n\n"
        puts "\t*****************************************************\n"
        exit(true)
    end
end
