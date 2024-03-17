class AddLikePosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :like, :float
  end
end
