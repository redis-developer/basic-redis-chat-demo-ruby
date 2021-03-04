class RoomMessagesController < ApplicationController
  before_action :load_entities

  def index
    @room_messages = Redis.new.hgetall('room_messages')
  end

  def create
    @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                       message: params.dig(:room_message, :message)
    Redis.new.hset('room_messages', @room_message.id, @room_message.message)

    ActionCable.server.broadcast 'room', @room_message
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
