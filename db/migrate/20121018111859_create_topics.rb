class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :body,     :null => false
      t.string :likeable,   :default => ""
      t.string :unlikeable, :default => ""
      t.integer :timeint

      t.timestamps
    end
  end
end
