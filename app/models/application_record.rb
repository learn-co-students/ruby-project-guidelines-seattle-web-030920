class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    
    def header(title)
        system "clear"
        puts "
        ██████╗ ██████╗ ██████╗███╗   █████████████████╗ █████╗ ████████╗  ███████████████╗ 
        ██╔══████╔═══████╔═══██████╗ ████╚══██╔══██╔══████╔══████╔════██║ ██╔██╔════██╔══██╗
        ██████╔██║   ████║   ████╔████╔██║  ██║  ██████╔█████████║    █████╔╝█████╗ ██████╔╝
        ██╔══████║   ████║   ████║╚██╔╝██║  ██║  ██╔══████╔══████║    ██╔═██╗██╔══╝ ██╔══██╗
        ██║  ██╚██████╔╚██████╔██║ ╚═╝ ██║  ██║  ██║  ████║  ██╚████████║  ███████████║  ██║
        ╚═╝  ╚═╝╚═════╝ ╚═════╝╚═╝     ╚═╝  ╚═╝  ╚═╝  ╚═╚═╝  ╚═╝╚═════╚═╝  ╚═╚══════╚═╝  ╚═╝
                                                                                            
        "
        display_user
        puts
        puts "***************#{title}***************"
        puts
        puts
    end

    def test
        puts "My inheritance is working!"
    end

    # def display_user
    #     if @user
    #         puts "currently logged in as #{@user.name}"
    #     end
    # end
end