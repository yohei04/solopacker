class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.datetime :date_time, null: false
      t.float :hour, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recruits, [:user_id, :created_at]
  end
end
