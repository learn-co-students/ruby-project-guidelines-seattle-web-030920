class Menu
    attr_reader :menu, :input, :menu_to_return_to, :my_menu_name, :sleep_time, :output_statement
    # def initialize()        
    # end    

    def menu_routine(input: nil, prompt: "Selection")
        Screen.clear
        puts menu
        puts input
        print "\n\t#{prompt}:> "
        @sleep_time = 0
    end        

    def output_formatting(output)
        @output_statement = "\n\t#{output}\n"
    end

    def successful_selection(output)        
        output_formatting(output)
        @sleep_time = 1                
    end

    def bad_selection(output)
        output_formatting(output)
        @input = nil     
        @sleep_time = 3               
    end

    def selection_result_output        
        puts @output_statement
        sleep(@sleep_time)
        @output_statement = "" 
    end
end

class MenuHelpers
    def self.Main
        "main"
    end

    def self.User
        "user"
    end

    def self.Login
        "login"
    end

    def self.Bike
        "bike"
    end

    def self.Trip
        "trip"
    end

    def self.CreateUser
        "create_user"
    end

    def self.CreateBike
        "create_bike"
    end

    def self.CreateTrip
        "create_trip"
    end
end
