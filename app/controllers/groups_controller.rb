class GroupsController < ApplicationController
  
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  
  def index
    if params[:search].present?
      @groups = Group.search(params[:search])
      if @groups.empty?
        flash[:alert] = '検索結果はありません。'
      end
    else
      @groups = Group.none
      flash[:alert] = '検索欄が空です。何かキーワードを入力してください。'
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @groups = params[:search].present? ? Group.search(params[:search]) : Group.all
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
  if @group.save
    #ownerのgroup_userを登録
    @group_user = GroupUser.new
    @group_user.group_id = @group.id
    @group_user.user_id = @group.owner_id
    @group_user.save
    redirect_to new_group_path, notice: 'グループを作成しました'
  else
    render :new
  end
  end

  def edit
  end

  def update
  end
  
  def destroy
    @group.destroy
    redirect_to new_group_path, notice: 'グループを削除しました'
  end
  
  def remove_member
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    if group.owner == current_user
      group.users.delete(user)
      redirect_to group_members_path(group), notice: "#{user.name}をグループから脱退させました"
    else
      redirect_to group_path(group), alert: "権限がありません"
    end
  end
  
  private
  
  def set_group
    @group = Group.find(params[:id])
  end
  
  def group_params
    params.require(:group).permit(:name, :purpose)
  end
  
  def check_owner
    unless @group.owner == current_user
      redirect_to groups_path, alert: 'You are not authorized to perform this action.'
    end
  end
  
end
