class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: :destroy
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
      if @comment.save
        #respond_to do |format|
          # format.html { redirect_to post_path(@post), notice: 'コメントを投稿しました' }
          #format.js
        #end
        render "create.js.erb"
      else
        respond_to do |format|
          format.html { redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました' }
          format.js
        end
      end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
