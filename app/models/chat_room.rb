class ChatRoom < ApplicationRecord
  
  has_many :chats, dependent: :destroy
  has_many :users, through: :chats
  
end
