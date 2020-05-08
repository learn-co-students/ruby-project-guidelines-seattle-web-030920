room_types = ["K", "QQ", "Lux Suite", "Jr Suite"]
room_status = ["Clean", "Dirty", "OOO"]
room_occupied = [true, false]

employee_name = ["Jeff", "Paul", "Frank", "Kenny", "Sue", "Virginia", "Netti", "Anne", "Sarah", "Mark"]
employee_dept = ["Office", "Housekeeping", "Maintenance", "Manager"]

20.times do
    room = Room.create
    room.room_number = room.id
    room.room_type_code = room_types.sample
    room.room_status = room_status.sample
    room.occupied = room_occupied.sample
    room.save
end

10.times do
    employee = Employee.create
    employee.name = employee_name.uniq.sample
    employee.department = employee_dept.sample
    employee.password = "1234"
    employee.save
end