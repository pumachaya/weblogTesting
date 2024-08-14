class MainController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  
  def index
    @posts = Post.all
    
    respond_to do |format|
      format.html # This will render index.html.erb by default
      format.json { render json: @posts, status: :ok }
    end
  end

  def show
    @post = Post.find(params[:id])
  
    respond_to do |format|
      format.html # This will render show.html.erb by default
      format.json { render json: @post, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { render file: 'public/404.html', status: :not_found }
      format.json { render json: { error: "Post Not Found" }, status: :not_found }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post Not Found" }, status: :not_found
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: { message: "Post has been deleted" }, status: :ok
    else
      render json: { error: "Post could not be deleted" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post Not Found" }, status: :not_found
  end

  private
  def post_params
    # params.permit(:title, :body, :author)
    params.require(:post).permit(:title, :body, :author)
  end
end
