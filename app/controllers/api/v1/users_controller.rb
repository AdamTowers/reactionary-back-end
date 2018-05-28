module Api
  module V1

    class UsersController < ApplicationController
      def index
        @users = User.all

        render json: @users, status: 200
      end

      def create
        @user = User.new(username: params["username"], password: params["password"], room_id: 1)
        if @user.valid?
          @user.save
          render json: token_json(@user)
        else
          #how do we show errors?
          #still allows user to view the canvas, even though token is undefined
          render json: { go_away: true }, status: :unauthorized
        end
      end

      def show
        @user = @user.find(params[:id])

        render json: @user, status: 200
      end

      def edit
        @user = User.find_by(id: params[:user_id])

        if (authorized?(@user))
          render json: @user
        else
          render json: { go_away: true }, status: :unauthorized
        end
      end

    end
  end
end
