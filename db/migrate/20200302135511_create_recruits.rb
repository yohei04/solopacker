class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.time :date, null: false
      t.time :time, null: false
      t.float :hours, null: false
      t.string :meet_country, null: false
      t.string :meet_city, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recruits, [:user_id, :created_at]
  end
end
