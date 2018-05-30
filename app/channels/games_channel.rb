class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}"
    user_room = UserRoom.find_by(room_id: params['room'].split("_")[1].to_i, user_id: params['user_id'].to_i)
    if !user_room
      UserRoom.create(room_id: params['room'].split("_")[1].to_i, user_id: params['user_id'].to_i)
      user = User.find(params['user_id'].to_i)

      ActionCable.server.broadcast("#{params[:room]}",
        { type: "join",
          user: {
            id: params['user_id'],
              attributes: {
           username: user.username
           }
        },
         random:'asdf'}
       )
    end
  end

  def unsubscribed
    user_room = UserRoom.find_by(room_id: params[:room].split("_")[1].to_i, user_id: params['user_id'].to_i)
    if user_room
      user = User.find(params['user_id'].to_i)
      ActionCable.server.broadcast("#{params[:room]}",
        { type: "disconnect",
          userId: params['user_id'],
          username: user.username,
          random:'asfd'
          })
      user_room.destroy
    end
  end

  def receive(data)
    if data['type'] == 'disconnect'
      user_room = UserRoom.find_by(room_id: params[:room].split("_")[1].to_i, user_id: params['user_id'].to_i)
      if user_room
        user_room.destroy
      end
    elsif data['type'] == 'delete_game'
      UserRoom.where(room_id: data['to'].split("_")[1]).destroy_all
      Room.find(data['to'].split("_")[1]).destroy
      ActionCable.server.broadcast("rooms_#{data['to'].split("_")[1]}", data)
    end
    ActionCable.server.broadcast("#{data['to']}", data)
  end
end
