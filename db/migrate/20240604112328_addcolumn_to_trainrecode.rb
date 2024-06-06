class AddcolumnToTrainrecode < ActiveRecord::Migration[7.1]
  def change
    add_column :trainrecodes, :date, :integer
  end
end
