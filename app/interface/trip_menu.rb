class TripMenu < Menu
    attr_reader :account
    def initialize(account)
        @menu = <<-TRIP_MENU
        ********  Bike Menu  **********                       
        5. ADD A TRIP
        7. TOTAL DISTANCE OF ALL TRIPS
        9. USER MENU - (GO BACK)
        ***************************
        TRIP_MENU

        @input = nil
        @account = account
        @my_menu_name = MenuHelpers.Trip 
        @menu_to_return_to = @my_menu_name   
    end

    def sub_menu_calulate_total_distance              
        trip_distance = Trip.all.select{|trip| trip.biker_id == @account.id}.map{|trip| trip.distance_miles}.reduce{|sum, next_item| sum = sum + next_item}
        string_bld1 = "\n\t\t\t********************************* TOTAL TRIP DISTANCE *********************************\n"
        string_bld2 = "\n\t\t\t#{trip_distance} miles"        
        "#{string_bld1}#{string_bld2}\n\n"            
    end
    
    def input=(input)
        data_valid = false;        
        if(input.length == 1)      
            valid_choices = ["5", "7", "9"]                        
            if(valid_choices.any?(input))
                @input = input
                data_valid = true
                case input
                when "5"                  
                    @menu_to_return_to = CreateTripMenu.new(@account).menu_routine
                when "7"                    
                    puts sub_menu_calulate_total_distance
                    puts "Press any key to continue"
                    gets.chomp 
                when "9"
                    puts "User menu"                    
                    @menu_to_return_to = MenuHelpers.User
                end     
            end
        end

        if(data_valid)
            @input = input
        else
            @input = nil
        end 

    end

    def sub_menu_data
        trips = Trip.all.select{|trip| trip.biker_id == @account.id}.map{|trip| "#{trip.to_s}"}.reduce{|sum, next_iter| sum = "#{sum}#{next_iter}"}
        string_bld1 = "\n\t\t\t********************************* TRIPS TAKEN BY #{account.full_name} *********************************\n"
        string_bld2 = "#{trips}"
        "#{string_bld1}#{string_bld2}\n"
    end

    def menu_routine()                           
        while(!@input || (@menu_to_return_to == @my_menu_name)) do                        
            super(input: sub_menu_data)            
            self.input=gets.chomp    
            selection_result_output             
        end  
        @menu_to_return_to      
    end
end