class Group < ApplicationRecord
  
  belongs_to :owner, class_name: 'User'
  
  has_many :events, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :messages, dependent: :destroy
  
  def self.search(search)
    if search.present?
      Group.where('name LIKE ? OR purpose LIKE ?', "%#{search}%", "%#{search}%")
    else
      Group.none
    end
  end

end