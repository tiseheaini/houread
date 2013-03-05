class CreateFeedMails < ActiveRecord::Migration
  def change
    create_table :feed_mails do |t|
      t.string :email
      t.boolean :is_delete, :default => false

      t.timestamps
    end
  end
end
