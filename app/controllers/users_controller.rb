class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :admin_user, only: :destroy
  
  def show
    @user = User.find(params[:id])
    @liked_posts = @user.likes.map(&:post)
    @groups = @user.groups
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @user = User.find(params[:id])
    @following = @user.following
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  
  # 他のアクションもここに追加します
  
end
