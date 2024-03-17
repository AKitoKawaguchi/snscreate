class CreateFavs < ActiveRecord::Migration[7.1]
  def change
    create_table :favs do |t|
      t.integer :follow
      t.integer :follower

      t.timestamps
    end
  end
end
