class CreateTripMenu < Menu
    attr_reader :account, :output_statement, :trip_name, :bike_selection, :start_city, :end_city, :distance_miles, :start_date, :end_date, :bikes, :new_bike, :bike
    def initialize(account)
        @menu = <<-CREATE_TRIP_MENU
        ********  Create Trip Menu *************               
        5. EDIT NEW TRIP DETAILS - WIP NOT FUNCTIONAL
        9. TRIP MENU
        ****************************************      
        CREATE_TRIP_MENU

        @account = account
        @input = nil
        @bikes = []
        @my_menu_name = MenuHelpers.CreateTrip
        @menu_to_return_to = @my_menu_name        
    end    

    def back_check(input)
        if(input == "!b")            
            successful_selection("Returning to trip menu")  
            @menu_to_return_to = MenuHelpers.Trip
            @input = input
            return true
        end
        return false
    end

    #:trip_name, :bike_selection, :start_city, :end_city, :distance_miles, :start_date, :end_date

    def is_numeric?(s)
        begin
          Float(s)
        rescue
          false # not numeric
        else
          true # numeric
        end
      end

    def bike_selection=(input)            
        if(input == "!b")
            @bike_selection = input
            successful_selection("(Cancled action) Returning to Trip menu")
            return
        end

        if(!is_numeric?(input))
            bad_selection("Please input a numeric index selection from the owned bike list for the trip.")
            @bike_selection = nil
            return
        end

        selection_range = (0...(@bikes.length))
        if(!(selection_range === input.to_i))
            bad_selection("Please input a numeric index selection from the owned bike list for the trip.")
            @bike_selection = nil
            return
        end

        @bike = @bikes[input.to_i]
    end

    def sub_menu_data
        @bikes = @account.bikes.each_with_index.map{|item,index| "#{index}#{item.to_s}"}.reduce{|sum, next_iter| sum = "#{sum}#{next_iter}"}
        string_bld1 = "\n\n\t\t\t********************************* BIKES OWNED BY #{account.full_name} *********************************\n"
        string_bld2 = "#{bikes}"
        "#{string_bld1}#{string_bld2}\n"
    end

    def edit_new_trip                               
        puts sub_menu_data
        if(@bikes == nil || @bikes.length == 0)
            bad_selection("User needs a bike before taking trips.  Please create bike first.")
            @input = nil
            return
        end
        print "Input trip name :>"
        @trip_name = gets.chomp
        
        while((self.bike_selection != "!b") && @new_trip == nil)
            print "\rInput bike index from available list above (left most number in list) - or !b to cancel :>"
            self.bike_selection = gets.chomp
        end

        print "Input trip name :>"
        @trip_name = gets.chomp
        
        print "Input start city :>"
        @start_city = gets.chomp



    end

    def input=(input)
        data_valid = false;          
        if(back_check(input))            
            return
        end       
        
        valid_choices = ["5", "9"]                        
        if(valid_choices.any?(input))
            @input = input
            data_valid = true
            case input                        
            when "5"
                puts "Edit New Trip"
                edit_new_trip
            when "9"
                #puts "Trip menu"                    
                @menu_to_return_to = MenuHelpers.Trip

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

