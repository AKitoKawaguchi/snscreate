class CreateTrainrecodes < ActiveRecord::Migration[7.1]
  def change
    create_table :trainrecodes do |t|
      t.integer :user_id, null: false
      t.text :trainnig
      t.text :food
      t.text :sleep

      t.timestamps
    end
  end
end
