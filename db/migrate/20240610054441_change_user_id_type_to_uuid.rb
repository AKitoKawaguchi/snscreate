class ChangeUserIdTypeToUuid < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :uuid, :uuid, null: false, default: 'gen_random_uuid()'
    add_column :likes, :user_uuid, :uuid
    add_column :notifications, :visitor_uuid, :uuid
    add_column :notifications, :visited_uuid, :uuid
    add_column :posts, :user_uuid, :uuid
    add_column :trainrecodes, :user_uuid, :uuid

    execute <<~SQL
      UPDATE likes SET user_uuid = users.uuid
      FROM users WHERE likes.user_id = users.id::integer;
      UPDATE notifications SET visitor_uuid = users.uuid
      FROM users WHERE notifications.visitor_id = users.id;
      UPDATE notifications SET visited_uuid = users.uuid
      FROM users WHERE notifications.visited_id = users.id;
      UPDATE posts SET user_uuid = users.uuid
      FROM users WHERE posts.user_id = users.id;
      UPDATE trainrecodes SET user_uuid = users.uuid
      FROM users WHERE trainrecodes.user_id = users.id;
    SQL

    remove_column :likes, :user_id
    remove_column :notifications, :visitor_id
    remove_column :notifications, :visited_id
    remove_column :posts, :user_id
    remove_column :trainrecodes ,:user_id

    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute 'ALTER TABLE users ADD PRIMARY KEY (id);'

    rename_column :likes, :user_uuid, :user_id
    rename_column :notifications, :visitor_uuid, :visitor_id
    rename_column :notifications, :visited_uuid, :visited_id
    rename_column :posts, :user_uuid, :user_id
    rename_column :trainrecodes, :user_uuid, :user_id

    add_foreign_key :likes, :users
    add_index :likes, :user_id
    change_column_null :likes, :user_id, false
    add_foreign_key :notifications, :users, column: :visitor_id
    add_index :notifications, :visitor_id
    change_column_null :notifications, :visitor_id, false
    add_foreign_key :notifications, :users, column: :visited_id
    add_index :notifications, :visited_id
    change_column_null :notifications, :visited_id, false
    add_foreign_key :posts, :users
    add_index :posts, :user_id
    change_column_null :posts, :user_id, false
    add_foreign_key :trainrecodes, :users
    add_index :trainrecodes, :user_id
    change_column_null :trainrecodes, :user_id, false
  end
end
