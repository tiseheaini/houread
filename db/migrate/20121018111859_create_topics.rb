class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title,  :null => false
      t.text :body,     :null => false
      t.text :likeable
      t.text :unlikeable
      t.integer :timeint

      t.timestamps
    end
  end
end
