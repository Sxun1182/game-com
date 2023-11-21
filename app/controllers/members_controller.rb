class MembersController < ApplicationController
  
def index
  @group = Group.find(params[:group_id])
  @group_users = @group.group_users
end
  
end
