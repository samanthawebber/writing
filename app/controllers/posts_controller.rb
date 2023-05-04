class PostsController < ApplicationController

  def home
  end

  def search
    @category = params[:category]
    @keyword  = params[:keyword]
    @category.empty? ? @posts = Post.all : @posts = Post.where(category: @category)
    @posts = @posts.where("lower(content) like ?", "%#{@keyword.downcase}%").order(created_at: :desc)
    render 'index'
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post     = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :subtitle, :category, :content))
      flash[:success] = "#{@post.title} successfully updated."
      redirect_to post_url(@post)
    else
      flash.now[:error] = "#{@post.title} update failed."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :subtitle, :category, :content)
  end
end
