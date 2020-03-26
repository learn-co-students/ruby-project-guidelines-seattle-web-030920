class Menu
    attr_reader :menu, :input, :menu_to_return_to, :my_menu_name
    # def initialize()        
    # end    

    def menu_routine(input: nil, prompt: "Selection")
        Screen.clear
        puts menu
        puts input
        print "\n\t#{prompt}:> "
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
