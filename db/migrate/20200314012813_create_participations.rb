class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recruit, null: false, foreign_key: true

      t.timestamps
    end
    add_index :participations, [:user_id, :recruit_id], unique: true
  end
end
