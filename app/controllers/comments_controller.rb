class CommentsController < ApplicationController
  # Ensure that the authenticity token is verified for HTML requests
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  
  def index
    @post = Post.find(params[:main_id])
    @comments = @post.comments
    render json: @comments, status: :ok
  rescue ActiveRecord::RecordNotFound
    # Handle case where the post cannot be found
    render json: { error: "Post Not Found" }, status: :not_found
  end

  def show
    @post = Post.find(params[:main_id])
    @comment = @post.comments.find(params[:id])
    render json: @comment, status: :ok
  rescue ActiveRecord::RecordNotFound
    # Handle cases where the post or comment cannot be found
    render json: { error: "Post or Comment Not Found" }, status: :not_found
  end

  def create
    @post = Post.find(params[:main_id])
    @comment = @post.comments.new(comment_params)

    if @comment.save
      # If the comment is saved successfully, respond with a JSON representation of the comment
      render json: @comment, status: :created
    else
      # If the comment fails to save, respond with an error message
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:main_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      # If the comment is updated successfully, respond with a JSON representation of the comment
      render json: @comment, status: :ok
    else
      # If the comment fails to update, respond with an error message
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    # Handle cases where the post or comment cannot be found
    render json: { error: "Post or Comment Not Found" }, status: :not_found
  end

  def destroy
    @post = Post.find(params[:main_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      # If the comment is deleted successfully, respond with a success message
      render json: { message: "Comment has been deleted" }, status: :ok
    else
      # If the comment fails to delete, respond with an error message
      render json: { error: "Comment could not be deleted" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    # Handle cases where the post or comment cannot be found
    render json: { error: "Post or Comment Not Found" }, status: :not_found
  end

  private
  # Strong parameters to permit only the allowed attributes
  def comment_params
    params.require(:comment).permit(:commenter, :body)
    # params.permit(:commenter, :body)
  end
end