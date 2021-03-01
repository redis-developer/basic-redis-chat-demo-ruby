class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"
  end
end
