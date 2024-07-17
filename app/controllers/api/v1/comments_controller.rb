class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_post
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = @post.comments
    render json: Panko::ArraySerializer.new(@comments, each_serializer: CommentSerializer).to_json
  end

  # GET /comments/1
  def show
    render json: CommentSerializer.new.serialize(@comment).to_json
  end

  # POST /comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @current_user.id
    
    if @comment.save
      render json: CommentSerializer.new.serialize(@comment).to_json, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: CommentSerializer.new.serialize(@comment).to_json
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @comment.destroy
      render json: CommentSerializer.new.serialize(@comment).to_json
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
