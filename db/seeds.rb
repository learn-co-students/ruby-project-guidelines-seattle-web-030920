room_types = ["K", "QQ", "Lux Suite", "Jr Suite"]
room_status = ["Clean", "Dirty", "OOO"]
room_occupied = [true, false]
20.times do
    room = Room.create
    room.room_number = room.id
    room.room_type_code = room_types.sample
    room.room_status = room_status.sample
    room.occupied = room_occupied.sample
    room.save
end