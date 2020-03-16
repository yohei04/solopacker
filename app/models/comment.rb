class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recruit
  validates :user_id, presence: true
  validates :recruit_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end
