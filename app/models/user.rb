class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :messages
  
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chats, foreign_key: :sender_id
  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id
  #has_many :groups, foreign_key: :owner_id
  # 他の関連付けもここに追加
  
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  def following?(other_user)
    following.include?(other_user)
  end
  
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end
  
  def following_count
    self.following.count
  end
  
  def followers_count
    self.followers.count
  end
  
end
