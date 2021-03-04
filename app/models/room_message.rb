class RoomMessage < ApplicationRecord
  validates :message, presence: true

  belongs_to :room, inverse_of: :room_messages
  belongs_to :user

  before_save :save_username

  def self.all_messages
    Redis.new.hgetall('room_messages')
  end

  private

  def save_username
    self.username = user.username
  end
end
