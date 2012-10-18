class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,     :null => false
      t.string :password_hash,:null => false
      t.string :password_salt,:null => false
      t.boolean :admin,       :default => 0

      t.timestamps
    end
  end
end
