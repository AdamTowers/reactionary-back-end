class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}"
  end

  def unsubscribed
    # user = User.find(params['user_id'])
    byebug
    user_room = UserRoom.find_by(room_id: params[:room].split("_")[1].to_i, user_id: params['user_id'].to_i)
    if user_room
      user_room.destroy
      ActionCable.server.broadcast("#{params[:room]}", {type: "disconnect", userId: params['user_id']})
    end

  end

  def receive(data)
    puts data
    puts 'SENDING TO GAME ROOM'
    ActionCable.server.broadcast("#{data['to']}", data)
  end
end
