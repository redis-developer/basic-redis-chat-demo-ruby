module UsersHelper
  def check_online(user)
    user.online? ? 'bg-success' : 'bg-gray'
  end
end
