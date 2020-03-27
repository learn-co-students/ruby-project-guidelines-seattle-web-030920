class CreateBikeMenu < Menu
    attr_reader :account, :output_statement, :bike_name, :manu_input, :manufacturer#, :account_name, :first_name, :last_name, :address
    def initialize(account)
        @menu = <<-CREATE_BIKE_MENU
        ********  Create Bike Menu *************       
        1. LIST MANUFACTURERS
        7. EDIT NEW BIKE DETAILS
        9. BIKE MENU
        ****************************************      
        CREATE_BIKE_MENU
        @account = account
        @input = nil
        @my_menu_name = MenuHelpers.CreateBike
        @menu_to_return_to = @my_menu_name        
    end    

    def back_check(input)
        if(input == "!b")            
            successful_selection("(Cancled action) Returning to main menu")  
            @menu_to_return_to = MenuHelpers.Bike
            @input = input
            return true
        end
        return false
    end

    def manu_input=(input)
        if(input == "!b")
            @manu_input = input
            successful_selection("(Cancled action) Returning to main menu")  
            return
        end
        @manu_input = input
        if(input == "C")
            @manufacturer = Manufacturer.find_by(name: "Custom")
            if(@manufacturer == nil)                
                @manufacturer = Manufacturer.create(name: "Custom", url: "")                
            end
        end
        if(@manufacturer == nil)
            binding.pry
            @manufacturer = Manufacturer.find(input)            
            if(@manufacturer == nil)
                @manu_input = nil
            end
        end            
    end


    def edit_bike                        
        print "Input bike name :>"
        @bike_name = gets.chomp
        print "Input bike type (anything) :>"
        @bike_type = gets.chomp        
        @manu_input = nil
        while((self.manu_input != "!b") && @manufacturer == nil)
            print "\rInput manufacturer id (either search manufacturers list for ID or enter \"C\" for custom frame) - or !b to cancel :>"
            self.manu_input = gets.chomp
        end

        @new_bike = nil
        if(@manufacturer == nil)
            bad_selection("Could not find manufacturer.  Please try again.")
        else            
            @new_bike = Bike.create(bike_name: @bike_name, biker_id: @account.id, bike_type: @bike_type, manufacturer_id: @manufacturer.id, stolen: false)
            if(@new_bike == nil)                
                bad_selection("Unable to create bike.  Please try again.")
            else                
                successful_selection("Successfully created bike with the following details #{@new_bike.to_s}") 
            end
        end
    end

    def input=(input)
        data_valid = false;          
        if(back_check(input))            
            return
        end       
        
        valid_choices = ["1", "7", "9"]                        
        if(valid_choices.any?(input))
            @input = input
            data_valid = true
            case input
            when "1"                  
                @menu_to_return_to = ManufacturerListMenu.new.menu_routine
            when "7"
                edit_bike
            when "9"
                puts "Bike menu"                    
                @menu_to_return_to = MenuHelpers.Bike

            end     
        end
    end

    def menu_routine                   
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "Selection")            
            self.input=gets.chomp   
            selection_result_output
        end
        @menu_to_return_to
    end
end

