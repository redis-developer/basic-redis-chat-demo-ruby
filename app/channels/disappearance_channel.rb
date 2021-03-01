class DisappearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "disappearance"
  end
end
