class PostsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @post = Post.new
    if params[:genre_id].present?
      @posts = Post.joins(:genres).where(genres: { id: params[:genre_id] }).order(created_at: :desc)
    else
      @posts = Post.order(created_at: :desc)
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
  
    if @post.save
      if params[:post][:tags].present?
        params[:post][:tags].split(',').each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name.strip)
         PostTag.create(post_id: @post.id, tag_id: tag.id)
        end
      end
      redirect_to posts_path
    else
      @posts = Post.all
      render :index
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
    if @post.update(post_params.except(:tags))
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def search
    if params[:keyword].present?
      @posts = Post.where('content LIKE ?', "%#{params[:keyword]}%")
    else
      @posts = []
      flash[:alert] = '検索欄が空です。何かキーワードを入力してください。'
    end
  end
  
  def tag_search
    if params[:tags].present?
      @posts = Post.joins(:tags).where(tags: { name: params[:tags].split(',') })
    else
      @posts = []
      flash[:alert] = '検索欄が空です。何かキーワードを入力してください。'
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :public)
  end
  
end
