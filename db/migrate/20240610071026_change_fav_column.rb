class ChangeFavColumn < ActiveRecord::Migration[7.1]
  def up
    remove_column :favs, :follow
    remove_column :favs, :follower
    add_column :favs, :follow, :uuid
    add_column :favs, :follower, :uuid
  end
end
