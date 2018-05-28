module Api
  module V1

    class RoomsController < ApplicationController
      def index
        if (valid_token?)
          render json: Room.all, status: 200
        else
          render json: { go_away: true }, status: :unauthorized
        end
      end

      def show
        @room = Room.find(params[:id])

        render json: @room, status: 200
      end
    end

  end
end
