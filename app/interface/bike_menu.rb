class BikeMenu < Menu
    attr_reader :account
    def initialize(account)
        @menu = <<-BIKE_MENU
        ********  Bike Menu  **********               
        1. EDIT A BIKE
        7. ADD A BIKE
        9. USER MENU
        ***************************
        BIKE_MENU

        @input = nil        
        @my_menu_name = MenuHelpers.Bike 
        @menu_to_return_to = @my_menu_name
        @account = account        
    end

    def input=(input)
        data_valid = false;        
        if(input == "!back")
            @input = input
            return
        end

        if(input.length == 1)        
            valid_choices = ["1", "5", "9"]                        
            if(valid_choices.any?(input))
                @input = input
                data_valid = true
                # 1. EDIT A BIKE
                # 5. ADD A BIKE
                # 9. USER MENU
                case input
                when "1"                         
                    puts "Edit a bike menu"                                                        
                when "5"
                    puts "Add a bike menu"
                when "9"                    
                    @menu_to_return_to = MenuHelpers.User  
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
        #while(!@input && @input != "9") do                    
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            bikes = Bike.all.select{|bike| bike.biker_id == @account.id}.map{|bike| bike.to_s}                 
            super(input: bikes)            
            self.input=gets.chomp         
        end        
        @menu_to_return_to   
    end
end