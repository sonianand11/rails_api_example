class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.includes(:comments, :user)
    
    render json: Panko::ArraySerializer.new(@posts, each_serializer: PostSerializer).to_json
  end

  # GET /posts/1
  def show
    render json: PostSerializer.new.serialize(@post).to_json
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    @post.medias.attach(post_params[:medias])

    if @post.save
      render json: PostSerializer.new.serialize(@post).to_json, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post.medias.attach(post_params[:medias])

    if @post.update(post_params)
      render json: PostSerializer.new.serialize(@post).to_json
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    
    if @post.destroy
      render json: PostSerializer.new.serialize(@post).to_json
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, medias:[])
    end
end
