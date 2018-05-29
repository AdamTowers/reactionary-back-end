class MessagesChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.broadcast("room-#{params[:room]}:messages", {
      # user_id: params.user_id,
      # room_id: "#{params[:room]}",
      # content
      })
    stream_from "room-#{params[:room]}:messages"
  end

  def unsubscribed

  end

  def receive(data)
    puts data
    ActionCable.server.broadcast("room-#{message.chatroom_id}:messages", data)
  end
end
