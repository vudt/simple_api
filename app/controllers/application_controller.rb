class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token
  acts_as_token_authentication_handler_for User, {fallback: :none, except: [:index, :create, :update]}
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalidation_response

  def render_invalidation_response(e)
    render json: e.record, serializer: ValidationErrorsSerializer, status: :bad_request
  end

  def load_user_authentication
    @user = User.find_by_email params[:email]
    render json: { message: "Invalid login" }, status: 200 unless @user
  end

  # rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  # protected 
  # def render_record_not_found_response(error, status: :not_found)
  #   render json: Errors::ActiveRecordNotFound.new(error).to_hash, status: status
  # end

  private 
  def current_user
    # biến đó != nil thì trả kq, còn = nil thì lấy result bên phải 
    @current_user ||= User.find_by(authentication_token: request.headers["Authorization"])
  end 

  def authenticate_user_from_token
    render json: { message: "You are not authenticated" }, status: 401 if current_user.nil?
  end
end
