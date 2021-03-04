module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :current_redis

    def connect
      self.current_user = find_verified_user
      self.current_redis = set_redis
    end

    private

    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed['user.id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def set_redis
      Redis.new
    end
  end
end
