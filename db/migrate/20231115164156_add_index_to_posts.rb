class AddIndexToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, :genre_id
  end
end
