class MessagesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @message = @group.messages.build(message_params)
    @message.user = current_user  # メッセージを作成するユーザーを設定
    if @message.save
      respond_to do |format|
        format.html { redirect_to @group }
        format.js
      end
    else
    # エラーハンドリング...
    end
  end


  private

  def message_params
    params.require(:message).permit(:content)
  end
end
