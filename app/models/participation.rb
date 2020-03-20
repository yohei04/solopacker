class Participation < ApplicationRecord
  belongs_to :user, inverse_of: :participations
  belongs_to :recruit, inverse_of: :participations
  validates :user_id, presence: true
  validates :recruit_id, presence: true, uniqueness: { scope: :user_id }
end
