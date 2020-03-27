class BikeMenu < Menu
    attr_reader :account
    def initialize(account)
        @menu = <<-BIKE_MENU
        ********  Bike Menu  **********               
        1. EDIT A BIKE - WIP NOT FUNCTIONAL
        5. ADD A BIKE
        9. USER MENU - (GO BACK)
        ***************************
        BIKE_MENU

        @input = nil        
        @my_menu_name = MenuHelpers.Bike 
        @menu_to_return_to = @my_menu_name
        @account = account        
    end

    def input=(input)             
        if(input.length == 1)        
            valid_choices = ["1", "5", "9"]                        
            if(valid_choices.any?(input))
                @input = input                
                # 1. EDIT A BIKE
                # 5. ADD A BIKE
                # 9. USER MENU
                case input
                when "1"  
                    puts "Not yet implemented"                
                    puts "Edit a bike menu"                                                        
                when "5"                    
                    puts "Add a bike menu"
                    @menu_to_return_to = CreateBikeMenu.new(@account).menu_routine
                when "9"                    
                    @menu_to_return_to = MenuHelpers.User  
                end     
            end
        else
            bad_selection("Account name is too short. Must be more that 4 or more characters.")           
        end
    end

    def sub_menu_data
        bikes = Bike.all.select{|bike| bike.biker_id == @account.id}.map{|bike| bike.to_s}.reduce{|sum, next_iter| sum = "#{sum}#{next_iter}"}
        string_bld1 = "\n\n\t\t\t********************************* BIKES OWNED BY #{account.full_name} *********************************\n"
        string_bld2 = "#{bikes}"
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