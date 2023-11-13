class ChatRoomsController < ApplicationController
  
  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.chats.order(created_at: :desc)
  end
  
  def index
    @chat_rooms = ChatRoom.all
  end
  
end
