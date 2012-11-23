class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :body,     :null => false
      t.string :like,   :default => ""
      t.string :unlike, :default => ""
      t.integer :timeint

      t.timestamps
    end
  end
end
