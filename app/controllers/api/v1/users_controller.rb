module Api
  module V1

    class UsersController < ApplicationController
      def index
        @users = User.all

        render json: @users, include: 'rooms'
      end

      def show
        @user = @user.find(params[:id])

        render json: @user, status: 200
      end

      def show_by_room
        users = User.joins(:user_rooms).where("user_rooms.room_id= #{params[:id]}")
        render json: users, status: 200
      end

      def create
        puts params
        @user = User.new(user_params)
        if @user.save
          @user.save
          render json: token_json(@user)
        else
          render json:  @user.errors.full_messages
        end
      end

      private
      def user_params
        params.require(:user).permit(:username, :password)
      end
    end

  end
end
