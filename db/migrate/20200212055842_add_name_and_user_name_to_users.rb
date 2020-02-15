class AddNameAndUserNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :user_name, :string, null: false
    add_index :users, :user_name, unique: true
  end
end
