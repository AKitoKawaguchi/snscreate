class Removenotificationfav < ActiveRecord::Migration[7.1]
  def change
    remove_column :notifications, :fav_id, :integer
    add_column :notifications, :like_id, :integer
  end
end
