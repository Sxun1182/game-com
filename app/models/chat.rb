class Chat < ApplicationRecord
  
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  # メッセージの内容を保存するためのカラムが必要
  
end
