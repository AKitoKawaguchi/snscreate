class Removenotificationpost < ActiveRecord::Migration[7.1]
  def change
    remove_column :notifications, :post_id, :integer
    add_column :notifications, :fav_id, :integer
  end
end
