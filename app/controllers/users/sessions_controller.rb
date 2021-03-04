class Users::SessionsController < Devise::SessionsController
  def new
    @users = User.order(:id).collect { |user| [user.username, user.id] }
    super
  end

  def create
    user = User.find(params[:id])
    if user.present? && user.valid_password?(params[:password])
      sign_in(user)
      Redis.new.del("logout_#{current_user.id}")
      broadcast(true)
      send_connect_message("#{current_user.username} connected") unless current_user.online?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    broadcast(false)
    send_connect_message("#{current_user.username} left") unless current_user.need_logout?
    sign_out(current_user)
    redirect_to root_path
  end

  def send_connect_message(message)
    room = Room.find_by(general: true)
    room_message = RoomMessage.create(room: room, user: current_user, message: message,
                                      connected_message: true)
    ActionCable.server.broadcast 'room', room_message
  end

  private

  def broadcast(online)
    ActionCable.server.broadcast 'appearance', user_id: current_user.id, online: online
  end
end
