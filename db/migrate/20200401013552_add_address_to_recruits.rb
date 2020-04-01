class AddAddressToRecruits < ActiveRecord::Migration[6.0]
  def change
    add_column :recruits, :address, :string, null: false
    add_column :recruits, :latitude, :float, null: false
    add_column :recruits, :longitude, :float, null: false
  end
end
