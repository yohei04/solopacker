class Join < ApplicationRecord
  belongs_to :user
  belongs_to :recruit
  validates :user_id, presence: true
  validates :recruit_id, presence: true
  validates_uniqueness_of :recruit_id, scope: :user_id
end
