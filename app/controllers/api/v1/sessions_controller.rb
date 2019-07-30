module Api::V1
  class SessionsController < Devise::SessionsController
    before_action :load_user_authentication

    def create
      if @user.valid_password? params[:password]
        sign_in @user, store: false
        render json:  @user, status: 200
        return
      end
      invalid_login_attemp
    end

    def destroy
      if @user.authentication_token == request.headers["Authorization"]
        sign_out @user
        render json: {message: "Signed out"}, status: 200
      else
        render json: {message: "Invalid token"}, status: 200
      end
    end

    private 
    def invalid_login_attemp
      render json: { message: "Sign in failed" }, status: 200
    end
  end
end
