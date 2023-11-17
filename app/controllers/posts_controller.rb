class PostsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    if params[:genre_id].present?
      @posts = Post.joins(:genres).where(genres: { id: params[:genre_id] }).order(created_at: :desc)
    else
      @posts = Post.order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if post_params[:tags].present?
      tags = post_params[:tags].split(',').map do |tag_name|
        Tag.find_or_create_by(name: tag_name.strip)
      end
      @post.tags = tags
    end
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if post_params[:tags].present?
      tags = post_params[:tags].split(',').map do |tag_name|
        Tag.find_or_create_by(name: tag_name.strip)
      end
      @post.tags = tags
    end
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def search
    @posts = Post.where('content LIKE ?', "%#{params[:keyword]}%")
  end
  
  def tag_search
    @posts = Post.joins(:tags).where(tags: { name: params[:tags].split(',') })
  end
  
  def genre_search
    @posts = Post.where(genre: params[:genre])
    render :index
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :genre, tags: [], genre_ids: [])
  end
  
end
