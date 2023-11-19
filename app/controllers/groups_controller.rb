class GroupsController < ApplicationController
  
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  
  def index
    @groups = Group.all
  end
  
  def show
  @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @groups = Group.all
  end

  def create
  @group = Group.new(group_params)
  @group.owner = current_user
  if @group.save
    redirect_to groups_path, notice: 'グループを作成しました'
  else
    render :new
  end
  end

  def edit
  end

  def update
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
