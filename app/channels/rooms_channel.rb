class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}"
  end

  def unsubscribed
    puts params
  end

  def receive(data)
    if data['type'] == 'create'
      room = Room.find(data['message']['room_id'])
      host = User.find(data['message']['user_id'])
      result = {
        id: room.id, type: 'create', attributes: {name: room.name, user_id: host.id}, relationships: {users:{data: [{id: host.id}]}}
      }
      ActionCable.server.broadcast("#{data['to']}", result)
    elsif data['type'] == 'join'
      if !UserRoom.find_by(user_id: data["message"]["user_id"].to_i, room_id: data["message"]["room_id"].to_i)
        ur = UserRoom.create(user_id: data["message"]["user_id"].to_i, room_id: data["message"]["room_id"].to_i)
        room = Room.find(ur.room_id)
        host = User.find(ur.user_id)
        relationships = {users: {data: []}}
        room.users.each do |u|
          relationships[:users][:data] << {id: host.id}
        end

        result = {
          id: room.id, type: 'join', attributes: {name: room.name, user_id: host.id}, relationships: relationships
        }
        ActionCable.server.broadcast("#{data['to']}", result)
      end
    end
  end
end
