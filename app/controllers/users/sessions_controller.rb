class Users::SessionsController < Devise::SessionsController
  def new
    @users = User.order(:id).collect { |user| [user.username, user.id] }
    super
  end

  def create
    user = User.find(params[:id])
    if user.present? && user.valid_password?(params[:password])
      sign_in(user)
      send_connect_message("#{current_user.username} connected")# unless current_user.online?
      user.update(online: true)
      ActionCable.server.broadcast 'appearance', user_id: current_user.id
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    ActionCable.server.broadcast 'disappearance', user_id: current_user.id
    current_user.update(online: false)
    send_connect_message("#{current_user.username} left")
    sign_out(current_user)
    ActionCable.server.remote_connections.where(current_user: current_user).disconnect
    redirect_to root_path
  end

  def send_connect_message(message)
    room = Room.find_by(general: true)
    room_message = RoomMessage.create(room: room, user: current_user, message: message,
                                      connected_message: true)
    ActionCable.server.broadcast 'room', room_message
  end
end
