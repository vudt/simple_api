module Api::V1
  class UsersController < Api::V1::ApiController
    def index 
      render json: {test: 'Abc'}
    end

    def show
      @user = User.find_by(id: params[:id], authentication_token: request.headers["Authorization"])
      render json:  @user, status: 200
    end

    def create
      # User.create!(user_params)
      user = User.new(user_params)
      if user.save
        render json: user, status: 200
      else
        render json: { success: false, errors: ValidationErrorsSerializer.new(user) }
      end
      # render json: {"success": true, data:{}}
    end

    def update
      # TODO update user
    end

    def sign_out
      @user = User.find_by(authentication_token: request.headers["Authorization"])
      if @user.authentication_token == request.headers["Authorization"]
        sign_out @user
        render json: {message: "Signed out"}, status: 200
      else
        render json: {message: "Invalid token"}, status: 200
      end
    end 

    private 
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
