class AddColumnToUserSetting < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :setting, :integer, default: 31111
  end
end
