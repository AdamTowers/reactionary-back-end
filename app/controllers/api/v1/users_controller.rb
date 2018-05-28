module Api
  module V1

    class UsersController < ApplicationController
      def index
        @users = User.all

        render json: @users, status: 200
      end

      def create
        @user = User.new(username: params["username"], password: params["password"])

        if @user.valid?
          @user.save
          render json: @user, status: 200
        else
          # not sure if we need flash[:errors] for this but if so:
          # flash[:errors] = @user.errors.full_messsages
          render json: @user
          # status?
        end
      end

      def show
        @user = @user.find(params[:id])

        render json: @user, status: 200
      end
    end

  end
end
