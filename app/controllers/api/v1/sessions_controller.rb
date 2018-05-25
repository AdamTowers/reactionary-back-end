class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params["username"])
    if (@user && @user.authenticate(params["password"]))
      render json: token_json(@user)
    else
      render json: {
        errors: "Those credentials don't match anything we have in our database"
      }, status: :unauthorized
    end
  end

end
