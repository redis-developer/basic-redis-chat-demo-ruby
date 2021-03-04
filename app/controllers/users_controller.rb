class UsersController < ApplicationController
  def index
    Redis.new.hgetall('online_users')
  end
end
