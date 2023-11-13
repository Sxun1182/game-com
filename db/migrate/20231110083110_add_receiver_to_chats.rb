class AddReceiverToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :receiver_id, :integer
  end
end
