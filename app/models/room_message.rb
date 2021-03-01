class RoomMessage < ApplicationRecord
  validates :message, presence: true

  belongs_to :room, inverse_of: :room_messages
  belongs_to :user

  before_save :save_username

  def as_json(options)
    super(options).merge(user_avatar_url: user.gravatar_url)
  end

  private

  def save_username
    self.username = user.username
  end
end
