class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room])
    stream_from "room"
  end
end
