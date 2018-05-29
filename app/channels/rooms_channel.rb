class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}"
    # LOGGED IN

  end

  def unsubscribed
    puts params
    # Any cleanup needed when channel is unsubscribed
    # UserRoom.find_by(user_id: params[:user_id], room_id: params[:room_id]).destroy
    # ActionCable.server.broadcast("rooms_#{params[:room]}", {user: params.user_id, room_id: params.room_id})
  end

  def receive(data)

    # puts data["message"]
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
        p "sending over "
        p result
        ActionCable.server.broadcast("#{data['to']}", result)
      end
    end

  end
end

# {<Switch>
#   <Route path="/" exact>
#     <Rooms />
#   </Route>
#
#   <Route path="/room/:room" exact render={ UserRoom } />
#
#   <Route render={
#       (renderProps) => {
#         console.log(renderProps)
#         return (<span>NOT FOUND</span>)
#       }
#    }/>
# </Switch>}
