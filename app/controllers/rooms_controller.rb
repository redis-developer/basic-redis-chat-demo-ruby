class RoomsController < ApplicationController
  before_action :load_entities

  def index; end

  def show
    @room_message = RoomMessage.new(room: @room)
    @room_messages = @room.room_messages.includes(:user)
  end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = Room.new(permitted_parameters)

    if @room.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
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
