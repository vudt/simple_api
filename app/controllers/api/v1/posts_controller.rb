module Api::V1
  class PostsController < Api::V1::ApiController
    before_action :set_post, only: [:show, :update, :destroy]

    def index 
      @posts = Post.all
      render json:  @posts, status: 200
    end

    def show
      render json:  @post, status: 200
    end 

    def create
      post = Post.create!(post_params)
      render json: post, status: 200
    end

    def update
      @post.update!(post_params)
      render json: @post, status: 200
    end

    def destroy
      @post.destroy!
      render json: {message: "Deleted Success"}, status: 200
    end

    private 
    def set_post
      @user = User.find_by!(authentication_token: request.headers["Authorization"])
      @post = @user.posts.find_by!(id: params[:id])
    end

    def post_params
      params.permit(:title, :description, :status, :user_id)
    end
  end 
end 