class ChatsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      redirect_to user_path(@chat.receiver_id), notice: 'メッセージを送信しました'
    else
      redirect_to user_path(@chat.receiver_id), alert: 'メッセージの送信に失敗しました'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id, :message)
  end
end
