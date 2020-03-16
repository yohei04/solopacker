class CreateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recruit, null: false, foreign_key: true

      t.timestamps
    end
    add_index :joins, [:user_id, :recruit_id], unique: true
  end
end
