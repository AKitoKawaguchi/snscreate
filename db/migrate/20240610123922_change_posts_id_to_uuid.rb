class ChangePostsIdToUuid < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :uuid, :uuid, null: false, default: 'gen_random_uuid()'
    add_column :likes, :post_uuid, :uuid
    add_column :notifications, :comment_uuid, :uuid
    add_column :hashtag_posts, :post_uuid, :uuid

    execute <<~SQL
      UPDATE likes SET post_uuid = posts.uuid
      FROM posts WHERE likes.post_id = posts.id::integer;
      UPDATE notifications SET comment_uuid = posts.uuid
      FROM posts WHERE notifications.comment_id = posts.id::integer;
      UPDATE hashtag_posts SET post_uuid = posts.uuid
      FROM posts WHERE hashtag_posts.post_id = posts.id::integer;
    SQL

    remove_column :likes, :post_id
    remove_column :notifications, :comment_id
    remove_column :hashtag_posts, :post_id

    change_table :posts do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute 'ALTER TABLE posts ADD PRIMARY KEY (id);'

    rename_column :likes, :post_uuid, :post_id
    rename_column :notifications, :comment_uuid, :comment_id
    rename_column :hashtag_posts, :post_uuid, :post_id

    add_foreign_key :likes, :posts
    add_index :likes, :post_id
    change_column_null :likes, :post_id, false
    add_foreign_key :notifications, :posts, column: :comment_id
    add_index :notifications, :comment_id
    change_column_null :notifications, :comment_id, false
    add_foreign_key :hashtag_posts, :posts
    add_index :hashtag_posts, :post_id
    change_column_null :hashtag_posts, :post_id, false
  end
end
