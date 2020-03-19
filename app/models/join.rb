class Join < ApplicationRecord
  belongs_to :user, inverse_of: :joins
  belongs_to :recruit, inverse_of: :joins
  validates :user_id, presence: true
  validates :recruit_id, presence: true, uniqueness: { scope: :user_id }
end
