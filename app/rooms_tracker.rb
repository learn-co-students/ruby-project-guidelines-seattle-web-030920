class RoomsTracker


    def run
        system "clear"
        welcome
        login_screen
        main_menu
    end
    
    def welcome
        header
        puts "Welcome to RoomTracker Inventory Management"
        puts "Created by David Knudson MMXX"
        puts
        press_any_key
        system "clear"
    end

    def display_user
        if @user
            puts "currently logged in as #{@user.name}"
        end
    end

    def login_screen
        header("login portal")
        puts
        puts "1) employee roster"
        puts
        puts "2) login"
        puts
        puts "q)uit"
        puts

         #TTY::Prompt keypress method constantly monitors keyboard for input
        selection = @prompt.keypress("please make your selection:")
        case selection
        when '1'
            view_employee_roster
            system "clear"
            login_screen
        when '2'
            login
        when 'q'
            exit
        else
            error
            login_screen
        end
        
    end

    def login
        system "clear"
        @user = nil
        header("login")
        puts
        puts "enter employee id:"
        @user = Employee.all.find_by(id: gets.chomp)
        if !@user
            puts "yeah...no".red
            login
        end
        puts
        puts "enter password:"

        # STDIN.noecho(&:gets).chomp allows chomp input with no echo
        @password = STDIN.noecho(&:gets).chomp

        check_password
    end

    def check_password
        if @password == @user.password
            puts "welcome back, #{@user.name}"
            puts
            press_any_key
        else
            system "clear"
            @password = ""
            @user = nil
            error
            login_screen
        end
    end



    def main_menu
        @prompt = TTY::Prompt.new
        system 'clear'
        header("main menu")
        puts
        puts "1) Rooms"
        puts
        puts "2) Work Orders"
        puts
        if @user.department == "Manager"
            puts "3) Employees"
            puts
        end
        puts "l)ogout"
        puts
        puts "q)uit"
        puts

         #TTY::Prompt keypress method constantly monitors keyboard for input
        selection = @prompt.keypress("Please make your selection:")
        case selection
        when '1'
            system "clear"
            rooms_menu
        when '2'
           system "clear"
           work_order_menu
        when '3'
            system "clear"
            @user.department == "Manager" ? employee_menu : (puts "access denied")
        when 'q'
            puts "Thank you for using RoomTracker!"
            exit
        when 'l'
            @user = nil
            login_screen
        else
            error
        end
    end


    # Menu 1 -- Room Functions

    def rooms_menu
        @prompt = TTY::Prompt.new

        system "clear"
        header("rooms menu")
        puts
        puts "1) room status report"
        puts
        puts "2) update room status"
        puts
        puts "3) return to the main menu"
        puts

        #TTY::Prompt keypress method constantly monitors keyboard for input
        selection = @prompt.keypress("Please make your selection:")

        case selection
        when '1'
            system "clear"
            room_report_table
            rooms_menu
        when '2'
            system "clear"
            room_report_table
            update_room_status
            rooms_menu
        when '3'
            main_menu
        else
            error
        end
    end

    def room_report_table
        header("room status report")
        puts

        #table created with terminal-table gem
        table = Terminal::Table.new do |t|
            t << ['Room Number', 'Room Type', 'Status', 'Occupied']
            t << :separator
        end
        Room.all.each do |room|
            table.add_row ["#{room.room_number}", "#{room.room_type_code}", "#{room.room_status}", occupied_converter(room.occupied)]
            table.add_separator
        end
        puts table
        press_any_key
    end

    #converts a boolean value to more readable for user
    def occupied_converter(value)
        if value == true
            "OCC"
        else
            "VAC"
        end
    end

    def update_room_status
        @prompt = TTY::Prompt.new

        header("update room status")
        puts
        puts "enter room number to update"
        room_to_be_updated = Room.find_by(id: gets.chomp.to_i)
        room_to_be_updated.room_status = @prompt.select("new status:", %w(Clean Dirty OOO))
        room_to_be_updated.occupied = @prompt.select("occupied status", %w(VAC OCC))
        press_any_key
        room_to_be_updated.save
        rooms_menu
    end


    #Menu 2 -- Work Order Functions

    def work_order_menu
        header("Work Order Menu")
        puts
        puts
        @prompt = TTY::Prompt.new

        puts "1) view all work orders"
        puts
        puts "2) view my work orders"
        puts
        puts "3) create new work order"
        puts
        puts "4} update work order"
        puts
        puts "5) delete work order"
        puts
        puts "6) return to main menu"
        puts
         #TTY::Prompt keypress method constantly monitors keyboard for input
        selection = @prompt.keypress("Please make your selection:")
        case selection
        when '1'
            system "clear"
            view_all_work_orders
            press_any_key
            work_order_menu
        when '2'
            system "clear"
            view_my_work_orders
            press_any_key
            work_order_menu
        when '3'
            system "clear"
            create_work_order
            work_order_menu
        when '4'
            system "clear"
            view_all_work_orders
            update_work_order
            work_order_menu
        when '5'
            system "clear"
            view_all_work_orders
            delete_work_order
            work_order_menu
        when '6'
            system "clear"
            main_menu
        else
            error
            work_order_menu
        end
    end

    def view_all_work_orders
        header("work orders report")
        puts
        table = Terminal::Table.new do |t|
            t << ['ID', 'Room Number', 'Assigned to', 'Details']
            t << :separator
        end
        WorkOrder.all.each do |work_order|
            emp_name = Employee.find_by(id: "#{work_order.employee_id}").name
            table.add_row ["#{work_order.id}", "#{work_order.room_id}", "#{work_order.employee_id} - #{emp_name}", "#{work_order.details}"]
            table.add_separator
        end
        puts table
        press_any_key
    end

    def view_my_work_orders

        #downcase and intepolate username into header
        header("#{@user.name}'s work orders".downcase)
        puts
        table = Terminal::Table.new do |t|
            t << ['ID', 'Room Number', 'Assigned to', 'Details']
            t << :separator
        end
        
        # my_work_orders = WorkOrder.select { |n| n.employee_id == @user.id}
        if !@user.work_orders
            work_order_menu
        end
        @user.work_orders.each do |work_order|
            table.add_row ["#{work_order.id}", "#{work_order.room_id}", "#{work_order.employee_id} -- #{@user.name}", "#{work_order.details}"]
            table.add_separator
        end
        puts table
        press_any_key
    end

    def create_work_order
        header("create work order")
        puts
        # @prompt = TTY::Prompt.new
        new_work_order = WorkOrder.create
        puts "enter room number:"
        new_work_order.room_id = gets.chomp
        puts "enter work description:"
        new_work_order.details = gets.chomp
        puts "assigned to:"
        new_work_order.employee_id = gets.chomp.to_i
        assigned_employee = find_employee_by_id(new_work_order.employee_id)
        new_work_order.save
        system "clear  "
        puts "work order #{new_work_order.id} created for room #{new_work_order.room_id} and assigned to #{assigned_employee.name}."
        press_any_key
    end

    def update_work_order
        header("update work order")
        puts
        @prompt = TTY::Prompt.new
        puts "enter work order id:"
        selected_id = gets.chomp.to_i
        to_be_updated = WorkOrder.find_by(id: "#{selected_id}")

        #check if object exists and if not returns to menu
        if !to_be_updated
            system "clear"
            puts "record does not exist!".red
            puts
            work_order_menu
        end

        puts "updating work order #{to_be_updated.id}"
        puts "enter new employee id:"
        to_be_updated.employee_id = gets.chomp
        puts
        puts "enter new description"
        to_be_updated.details = gets.chomp
        puts
        confirm = @prompt.yes?("are you sure you want to update work order #{to_be_updated.id}?")
        confirm ? to_be_updated.save : work_order_menu
        puts "record updated"
        press_any_key
        system "clear"
    end

    def delete_work_order
        header("delete work order")
        puts
        @prompt = TTY::Prompt.new
        puts "enter work order id:"
        selected_id = gets.chomp.to_i
        to_be_deleted = WorkOrder.find_by(id: "#{selected_id}")
        #check if id exists and if not returns to menu
        if !to_be_deleted 
            system "clear"
            puts "record does not exist!".red
            puts
            work_order_menu
        end
        confirm = @prompt.yes?("are you sure you want to delete work order ##{to_be_deleted.id}?")
        confirm ? to_be_deleted.delete : work_order_menu
        puts "record deleted"
        press_any_key
    end

    #Menu 3 -- Employee Functions

    def employee_menu
        header("employee functions")
        puts

        #TTY::Prompt keypress method constantly monitors keyboard for input
        @prompt = TTY::Prompt.new

        puts "1) view the employee roster"
        puts
        puts "2) add employee"
        puts
        puts "3) update employee details"
        puts
        puts "4) delete employee"
        puts
        puts "5) return to main menu"
        puts

        selection = @prompt.keypress("Please make your selection:").to_i
        case selection
        when 1
            view_employee_roster
            system "clear"
            employee_menu
        when 2
            add_employee
            system 'clear'
            employee_menu
        when 3
            view_employee_roster
            update_employee
            system 'clear'
            employee_menu
        when 4
            view_employee_roster
            delete_employee
            system 'clear'
            employee_menu
        when 5
            system "clear"
            main_menu
        else
            error
            press_any_key
        end
    end

    def view_employee_roster
        header("employee roster")
        # table created with terminal-table gem
        table = Terminal::Table.new do |t|
            t << ['ID', 'Name', 'Department']
            t << :separator
        end
        Employee.all.each do |employee|
            table.add_row ["#{employee.id}", "#{employee.name}", "#{employee.department}"]
            table.add_separator
        end
        puts table
        press_any_key
    end

    def add_employee
        header("add new employee")
        puts
        @prompt = TTY::Prompt.new
        new_employee = Employee.create
        puts "Welcome! Your new employee id is #{new_employee.id}."
        puts
        puts "Enter employee name:"
        new_employee.name = gets.chomp
        puts
        new_employee.department = @prompt.select("Choose employee department:", %w(Office Housekeeping Maintenance Manager))
        puts
        puts "Create a password:"

        # STDIN.noecho(&:gets).chomp allows chomp input with no echo
        new_employee.password = STDIN.noecho(&:gets).chomp
        new_employee.save
        puts
        puts "Welcome aboard, #{new_employee.name}! Your department is #{new_employee.department}, and your id# is #{new_employee.id}."
        puts
        press_any_key
    end

    def delete_employee
        header("delete employee")
        puts
        @prompt = TTY::Prompt.new
        puts "enter employee id:"
        selected_id = gets.chomp.to_i
        to_be_deleted = Employee.find_by(id: "#{selected_id}")
        #check if id exists and if not returns to menu
        if !to_be_deleted 
            system "clear"
            puts "record does not exist!".red
            puts
            employee_menu
        end
        puts
        confirm = @prompt.yes?("are you sure you want to delete #{to_be_deleted.name}?")
        confirm ? to_be_deleted.delete : employee_menu
        puts
        puts "record deleted"
        press_any_key
        system 'clear'
    end

    def update_employee
        header("update employee")
        puts
        @prompt = TTY::Prompt.new
        puts "enter employee id:"
        selected_id = gets.chomp.to_i
        to_be_updated = Employee.find_by(id: "#{selected_id}")
        #check if id exists and if not returns to menu
        if !to_be_updated
            system "clear"
            puts "record does not exist!".red
            puts
            employee_menu
        end
        puts
        puts "updating employee #{to_be_updated.id}"
        puts
        puts "enter new name:"
        to_be_updated.name = gets.chomp
        puts
        to_be_updated.department = @prompt.select("choose new department:", %w(Office Housekeeping Maintenance Manager))
        puts
        puts "enter new password:"
        # STDIN.noecho(&:gets).chomp allows chomp input with no echo
        to_be_updated.password = STDIN.noecho(&:gets).chomp
        puts
        confirm = @prompt.yes?("are you sure you want to update employee #{to_be_updated.id}?")
        confirm ? to_be_updated.save : employee_menu
        puts
        puts "record updated"
        press_any_key
        system "clear"
    end

    #miscellaneous methods

    def find_employee_by_id(employee_id)
        Employee.all.find_by(id: employee_id)
    end

    def header(title=nil)
        @prompt = TTY::Prompt.new
        system "clear"
        puts "
        ██████╗ ██████╗ ██████╗███╗   █████████████████╗ █████╗ ████████╗  ███████████████╗ 
        ██╔══████╔═══████╔═══██████╗ ████╚══██╔══██╔══████╔══████╔════██║ ██╔██╔════██╔══██╗
        ██████╔██║   ████║   ████╔████╔██║  ██║  ██████╔█████████║    █████╔╝█████╗ ██████╔╝
        ██╔══████║   ████║   ████║╚██╔╝██║  ██║  ██╔══████╔══████║    ██╔═██╗██╔══╝ ██╔══██╗
        ██║  ██╚██████╔╚██████╔██║ ╚═╝ ██║  ██║  ██║  ████║  ██╚████████║  ███████████║  ██║
        ╚═╝  ╚═╝╚═════╝ ╚═════╝╚═╝     ╚═╝  ╚═╝  ╚═╝  ╚═╚═╝  ╚═╝╚═════╚═╝  ╚═╚══════╚═╝  ╚═╝
                                                                                            
        ".blue
        if @user
            display_user
        end
        puts
        if title
            puts "***************#{title}***************"
        end
    end

    def press_any_key
        print "< press any key to continue >"
        STDIN.getch
        print "            \r" # extra space to overwrite in case next sentence is short
    end

    def error
        system "clear"
        puts "not quite!".red
        puts "please try again".red
        puts
        press_any_key
    end
end