class RemoveGenreFromPosts < ActiveRecord::Migration[6.1]
  def change
    #remove_reference :posts, :genre, null: false
  end
end
