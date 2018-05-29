module Api
  module V1

    class RoomsController < ApplicationController
      def index
        @rooms = Room.all

        render json: @rooms, status: 200
      end

      def show
        @room = Room.find(params[:id])

        render json: @room, status: 200
      end

      def create
        room = Room.new(room_params)
        if(room.save)
          UserRoom.create(user_id: params[:user_id], room_id: room.id)
          render json: room, status: 200
        end
      end

      private
      def room_params
        params.require(:room).permit(:name, :user_id)
      end
    end


  end
end
