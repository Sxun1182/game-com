class ChatsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      redirect_to chats_path
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id, :message)
  end
  
end
