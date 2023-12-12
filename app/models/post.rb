class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_and_belongs_to_many :genres
  
  validates :title, presence: true
  validates :content, presence: true
  
  has_many :post_tags
  has_many :tags, through: :post_tags
  
  validate :tags_presence

  private

  def tags_presence
    errors.add(:tags, "can't be blank") if tags.empty?
  end
  # has_and_belongs_to_many :tags
  
  #validates :genre, presence: true
  # acts_as_taggable_on :tags など、タグ機能を追加する場合はここに記述
  
end
