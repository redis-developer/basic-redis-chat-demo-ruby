module RoomsHelper
  def last_message(room)
    room.room_messages.last
  end

  def current_user_owner?(message)
    message.user == current_user
  end

  def check_position(message)
    current_user_owner?(message) ? 'text-right' : 'text-left'
  end

  def current_chat(id, room_id)
    id.to_i == room_id ? 'bg-white' : ''
  end

  def first_chat(id, room)
    id.nil? && room == Room.first ? 'bg-white' : ''
  end

  def opposite_user(room, user_id)
    id = room.name.split(':').map(&:to_i).delete_if { |i| i == user_id }.first
    User.find(id) unless room.general?
  end
end
