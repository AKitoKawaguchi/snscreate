class ChangeColumnToUser2 < ActiveRecord::Migration[7.1]
  def up
    change_column :users, :id, :integer
  end

  def down
    change_column :users, :id, :string
  end
end
