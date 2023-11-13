class AddSenderIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :sender_id, :integer
  end
end
