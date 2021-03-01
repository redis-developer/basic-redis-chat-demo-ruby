def create_room_message(users, room_name, general = false)
  greetings = %w[Hi Hello Alloha Hey Greeting]
  room = Room.find_or_create_by(name: room_name, general: general)
  users.each do |user|
    room_message = RoomMessage.create(user: user, room: room, message: greetings.sample)
  end
end

users = [{ 'Pablo': 'password123' }, { 'Joe': 'password123' }, { 'Mary': 'password123' }, { 'Alex': 'password123' }]
users.each do |hash|
  User.create(username: hash.keys.first, password: hash.values.first,
              email: "#{hash.keys.first.downcase}@gmail.com",
              avatar: "avatars/#{hash.keys.first.downcase}.jpg")
end

create_room_message(User.all, 'General', true)

create_room_message(User.where(id: [User.first.id, User.second.id]), "#{User.first.id}:#{User.second.id}")

create_room_message(User.where(id: [User.first.id, User.third.id]), "#{User.first.id}:#{User.third.id}")

create_room_message(User.where(id: [User.first.id, User.fourth.id]), "#{User.first.id}:#{User.fourth.id}")

create_room_message(User.where(id: [User.second.id, User.third.id]), "#{User.second.id}:#{User.third.id}")

create_room_message(User.where(id: [User.second.id, User.fourth.id]), "#{User.second.id}:#{User.fourth.id}")

create_room_message(User.where(id: [User.third.id, User.fourth.id]), "#{User.third.id}:#{User.fourth.id}")
