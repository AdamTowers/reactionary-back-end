class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_test"
    ActionCable.server.broadcast("rooms_test", {message: 'welcome'})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    room = "Test"
    UserRoom.create(user_id: data.user_id, room_id: data.room_id)

    ActionCable.server.broadcast('rooms_test', data)
  end
end
