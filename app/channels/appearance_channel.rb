class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_redis.set("user_#{current_user.id}_online", "1")
    current_redis.del("logout_#{current_user.id}")
    current_redis.hset('online_users', current_user.username, current_user.id)
    stream_from "appearance"
  end

  def unsubscribed
    current_redis.del("user_#{current_user.id}_online")
    current_redis.set("logout_#{current_user.id}", "1")
    current_redis.hdel('online_users', current_user.username)
    stream_from "appearance"
  end
end
