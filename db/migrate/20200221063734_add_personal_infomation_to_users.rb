class AddPersonalInfomationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string, null: false
    add_column :users, :origin, :string, null: false
    add_column :users, :current_city, :string, null: false
    add_column :users, :language_1, :string, null: false
    add_column :users, :language_2, :string
    add_column :users, :language_3, :string
    add_column :users, :introduce, :text
    add_column :users, :image, :string
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
