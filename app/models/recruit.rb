class Recruit < ApplicationRecord
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :hours, presence: true, numericality: { less_than_or_equal_to: 24 }
  validates :meet_country, presence: true
  validates :meet_city, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
