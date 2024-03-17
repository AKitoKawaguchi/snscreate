class RemovefollewsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :follews, :integer
    remove_column :users, :follewers, :integer
  end
end
