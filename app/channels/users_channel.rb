class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_in_room"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast('users_in_room', data)
  end
end
