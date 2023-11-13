class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :messages
  
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chats, foreign_key: :sender_id
  has_many :groups, foreign_key: :owner_id
  # 他の関連付けもここに追加
end
