class AddTocommentPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tocomment, :integer
  end
end
