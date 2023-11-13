class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  #validates :genre, presence: true
  # acts_as_taggable_on :tags など、タグ機能を追加する場合はここに記述
  
end
