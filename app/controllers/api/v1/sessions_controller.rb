module Api
  module V1

    class SessionsController < ApplicationController

      def create
        @user = User.find_by(username: params["username"])
        if @user && @user.authenticate(params[:password_digest])
          p token_json(@user)
          render json: token_json(@user)
        else
          render json: {
            errors: "Wrong username/password combination."
          }, status: :unauthorized
        end
      end
    end

  end
end
