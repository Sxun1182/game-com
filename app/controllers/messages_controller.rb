class MessagesController < ApplicationController
  def create
  group = Group.find(params[:group_id])
    message = group.messages.build(message_params)
    message.user = current_user
    if message.save
      redirect_to group, notice: 'メッセージを送信しました'
    else
      redirect_to group, alert: 'メッセージの送信に失敗しました'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
