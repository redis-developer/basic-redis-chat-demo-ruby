class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true

  has_many :room_messages,
           dependent: :destroy

  def online?
    Redis.new.get("user_#{self.id}_online").present?
  end

  def need_logout?
    Redis.new.get("logout_#{self.id}").present?
  end

  def self.online_users
    Redis.new.hgetall('online_users')
  end
end
