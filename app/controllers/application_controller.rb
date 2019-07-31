class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token
  acts_as_token_authentication_handler_for User, { fallback: :none, except: [:index, :show, :create, :update] }
  acts_as_token_authentication_handler_for Post, { fallback: :none, except: [:create] }
  

  def load_user_authentication
    @user = User.find_by_email params[:email]
    render json: { message: "Invalid login" }, status: 200 unless @user
  end

  private 
  def current_user
    @current_user ||= User.find_by(authentication_token: request.headers["Authorization"])
  end 

  def authenticate_user_from_token
    render json: { message: "You are not authenticated" }, status: 401 if current_user.nil?
  end
end
