class RemoveUnlikeableFromTopics < ActiveRecord::Migration
  def up
    remove_column :topics, :unlikeable
  end

  def down
    add_column :topics, :unlikeable, :text
  end
end
