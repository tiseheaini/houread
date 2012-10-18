class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :body,     :null => false
      t.integer :like,  :default => 0
      t.integer :unlike,:default => 0

      t.timestamps
    end
  end
end
