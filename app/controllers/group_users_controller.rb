class GroupUsersController < ApplicationController
  


def create
  @group = Group.find(params[:group_id])
  if @group.users.include?(current_user)
    redirect_to @group, alert: 'すでにグループに参加しています'
  else
    @group_user = @group.group_users.build(user: current_user)
    if @group_user.save
      redirect_to @group, notice: 'グループに参加しました'
    else
      puts @group_user.errors.full_messages # Rubyのputsメソッドを使用
      Rails.logger.info @group_user.errors.full_messages # Railsのloggerメソッドを使用
      redirect_to @group, alert: 'グループへの参加に失敗しました'
    end
  end
end



end