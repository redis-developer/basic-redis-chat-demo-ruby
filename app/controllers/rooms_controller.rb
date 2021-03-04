class RoomsController < ApplicationController
  before_action :load_entities

  def index
    @rooms = Redis.new.hgetall('rooms')
  end

  def show
    @room_message = RoomMessage.new(room: @room)
    @room_messages = @room.room_messages.includes(:user)
  end
  
  protected

  def load_entities
    @rooms = Room.joins(:users).where(users: { id: current_user.id }).uniq
    @room = params[:id].present? ? Room.find(params[:id]) : Room.first
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
