class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :follews
      t.integer :follewers

      t.timestamps
    end
  end
end
