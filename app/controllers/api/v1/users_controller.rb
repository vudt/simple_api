module Api::V1
  class UsersController < Api::V1::ApiController
    before_action :set_user, only: [:show, :update, :destroy]

    def index 
      render json: {test: 'Abc'}
    end

    def show
      render json:  @user, status: 200
    end

    def create
      user = User.create!(user_params)
      render json: user, status: 200
    end

    def update
      @user.update!(user_params)
      render json: @user, status: 200
    end

    def destroy
      @user.destroy
      render json: {message: "Deleted Success"}, status: 200
    end

    private 
    def set_user
      @user = User.find_by!(id: params[:id], authentication_token: request.headers["Authorization"])
    end

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
