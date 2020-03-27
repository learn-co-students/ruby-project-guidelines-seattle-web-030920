class ComicsApp
    attr_reader :user, :apikey
    def run
    welcome
    menu_selection
    end


    def welcome
        @apikey = "?api_key=2b3c295c4c8350673ddace9e9ebad398c5c1922b"
        system "clear"
         puts "Hello! Welcome to Comics App!"
    end

    def menu_selection
        if @user
            puts "Hi #{@user.username}!"
        end
        puts
        puts "What would you like to do?"
        puts "1. Log In"
        puts "2. Add Someting to Favorites"
        puts "3. Change or Delete Favorites"
        puts "4. See My Favorites"
        puts "5. Look Up Character Bio"
        puts "6. Look Up Creator Bio"
        puts "7. Find Characters by Creator"
        puts "8. Exit Application"
        selected = gets.chomp.to_i
        case selected
        when 1
            login
        when 2
            add_to_favorites
        when 3
            delete_favorite
        when 4
            display_user_favorites
        when 5
            lookup_character_bio
        when 6
            lookup_creator_bio
        when 7
            find_characters_by_creator
        when 8
            puts "Thank you for using Comic App!"
            exit(true)
        else
            puts "Invalid Selection!"
            menu_selection
        end
    end

    def login
        puts "Enter username:"
        username = gets.chomp
        @user = User.find_or_create_by(username: username)
        system "clear"
        menu_selection
    end

    def add_to_favorites
        if !@user
            puts "You Must Be Logged In To Do That!"
            menu_selection
        end
        puts "What would you like to add?"
        puts "Enter 1 for Creator or 2 for Character:"
        selection = gets.chomp.to_i
        case selection
        when 1
            puts "Enter Name of Creator:"
            search_key = "Creator"
            input = format_for_search(gets.chomp)
            res = RestClient.get("https://comicvine.gamespot.com/api/people/#{apikey}&filter=name:#{input}&field_list=api_detail_url&format=json")
            creator_stub = JSON.parse(res.body)
            creator_url = creator_stub["results"][0]["api_detail_url"]
            res2 = RestClient.get("#{creator_url}#{apikey}&format=json")
            creator_sheet = JSON.parse(res2.body)
            Favorite.create(name: creator_sheet["results"]["name"], search_key: search_key, user_id: @user.id)
        when 2
            puts "Enter Name of Character:"
            search_key = "Character"
            search_string = format_for_search(gets.chomp)
            res = RestClient.get("https://comicvine.gamespot.com/api/characters/#{apikey}&filter=name:#{search_string}&format=json")
            search_result = JSON.parse(res.body)
            Favorite.create(name: search_result["results"][0]["name"], search_key: search_key, user_id: @user.id)
        else
            puts "Invalid Selection"
            add_to_favorites
        end
        
        system "clear"
        puts "#{input} Added to Favorites"
        menu_selection
    end
    
    def display_user_favorites
        if !@user
            puts "You Must Be Logged In To Do That!"
            menu_selection
        end
        user_favorites = Favorite.where(user_id: @user.id)
        system "clear"
        puts "Your Favorites are :"
        user_favorites.each { |fav| puts "#{fav.name}"}
        puts
        puts
        menu_selection
    end

    def delete_favorite
        user_favorites = Favorite.where(user_id: @user.id)
        user_favorites.each do |fav|
            puts "#{fav.id} #{fav.name}"
        end
        puts
        puts "Which Number Would You Like To Modify?"
        input = gets.chomp.to_i
        selected = Favorite.where(id: input)
        puts
        puts "Enter 'c' to change or 'd' to delete"
        change_input = gets.chomp
        if change_input != "c" && change_input != "d"
            puts "Invalid Input!"
            delete_favorite
        end

        case change_input
        when "c"
            record = Favorite.find_by(id: input)
            puts "Enter a New Name"
            new_name = gets.chomp
            record.name = new_name
            record.save
            system "clear"
            menu_selection
        when "d"
            record = Favorite.find_by(id: input)
            record.destroy
            system "clear"
            menu_selection
        end
        # binding.pry
    end

    def lookup_character_bio
        puts "Enter a Character:"
        search_string = format_for_search(gets.chomp)
        res = RestClient.get("https://comicvine.gamespot.com/api/characters/?api_key=2b3c295c4c8350673ddace9e9ebad398c5c1922b&filter=name:#{search_string}&format=json")
        search_result = JSON.parse(res.body)
        puts
        puts "A Character in #{search_result["results"][0]["first_appeared_in_issue"]["name"]}"
        puts search_result["results"][0]["deck"]
        puts "Real Name: #{search_result["results"][0]["real_name"]}"
        puts
        puts
        press_any_key
        system "clear"
        menu_selection
    end

    def lookup_creator_bio
        puts "Enter a Creator:"
        search_string = format_for_search(gets.chomp)
        res = RestClient.get("https://comicvine.gamespot.com/api/people/#{apikey}&filter=name:#{search_string}&field_list=api_detail_url&format=json")
        creator_stub = JSON.parse(res.body)
        creator_url = creator_stub["results"][0]["api_detail_url"]
        res2 = RestClient.get("#{creator_url}#{apikey}&format=json")
        creator_sheet = JSON.parse(res2.body)
        puts
        puts creator_sheet["results"]["name"]
        puts creator_sheet["results"]["deck"]
        puts
        puts
        press_any_key
        system "clear"
        menu_selection
    end

    def find_characters_by_creator
        puts
        puts "Enter the Creator Whose Characters You Wish to View:"
        input = format_for_search(gets.chomp)
        res = RestClient.get("https://comicvine.gamespot.com/api/people/#{apikey}&filter=name:#{input}&field_list=api_detail_url&format=json")
        creator_stub = JSON.parse(res.body)
        creator_url = creator_stub["results"][0]["api_detail_url"]
        res2 = RestClient.get("#{creator_url}#{apikey}&format=json")
        creator_sheet = JSON.parse(res2.body)
        creator_sheet["results"]["created_characters"].each do |character|
            puts character["name"]
        end
        puts
        puts "Enter Selection:"
        puts "1. Get Character Bio"
        puts "2. Get Creator Bio"
        puts "Or Press [return] to Main Menu"
        select_option = gets.chomp.to_i

        case select_option
        when 1
            lookup_character_bio
        when 2
            puts creator_sheet["results"]["name"]
            puts creator_sheet["results"]["deck"]
            puts
            puts
            press_any_key
            system "clear"
            menu_selection
        else
            system "clear"
            menu_selection
        end
    end 

    def lookup_volumes_by_writer
    end

    def lookup_volumes_by_character
    end

    def format_for_search(input)
        input.downcase.gsub(" ", "_")
    end

    def press_any_key
        print "Press Any Key to Return to the Menu"
        STDIN.getch
        print "            \r" # extra space to overwrite in case next sentence is short
    end
end