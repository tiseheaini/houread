class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :body,     :null => false
      t.string :like
      t.string :unlike
      t.integer :timeint

      t.timestamps
    end
  end
end
