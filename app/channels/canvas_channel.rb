class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}"
    # ActionCable.server.broadcast("#{params[:room]}", params)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # ActionCable.server.broadcast("CanvasChannel")
  end

  def receive(data)
    ActionCable.server.broadcast("#{params[:room]}", data)
  end
end
