class ManufacturerListMenu < Menu
    attr_reader :output_statement
    def initialize()
        @menu = <<-MANUFACTURER_LIST_MENU
        ********  Manufacturer Search Menu *************       
        Key in manufacturer name to search for

        !b - previous menu
        ****************************************      
        MANUFACTURER_LIST_MENU

        @input = nil
        @my_menu_name = MenuHelpers.MaufacturerList
        @menu_to_return_to = @my_menu_name        
    end    

    def back_check(input)
        if(input == "!b")            
            successful_selection("Returning to trips menu")  
            @menu_to_return_to = MenuHelpers.CreateBike
            @input = input
            return true
        end
        return false
    end

    def input=(input)
        data_valid = false;          
        if(back_check(input))            
            return
        end       
        
        puts sub_menu_data(input)    
        puts "Press any key to continue"
        gets.chomp    
    end

    def sub_menu_data(input)                
        manu_match = Manufacturer.all.select{|manu| manu.name.downcase.include?(input.downcase)}.map{|manu| "#{manu.to_s}"}.reduce{|sum, next_iter| sum = "#{sum}#{next_iter}"}
        string_bld1 = "\n\t\t\t********************************* MANUFACTURERS MATCHING SEARCH \"#{input}\" *********************************\n"
        string_bld2 = "#{manu_match}"        
        "#{string_bld1}#{string_bld2}\n"            
    end

    def menu_routine                   
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            super(prompt: "Search for ")            
            self.input=gets.chomp   
            selection_result_output
        end
        @menu_to_return_to
    end
end

