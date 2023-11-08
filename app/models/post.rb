class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments
  has_many :likes
  # acts_as_taggable_on :tags など、タグ機能を追加する場合はここに記述
  
end
