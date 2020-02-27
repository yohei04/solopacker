class ChangeColumnNullOfUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :gender, true
    change_column_null :users, :origin, true
    change_column_null :users, :current_city, true
    change_column_null :users, :language_1, true
  end
end
