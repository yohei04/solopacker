class AddCurrentCountryToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_country, :string
  end
end
