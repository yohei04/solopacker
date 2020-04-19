class Recruit < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user
  scope :create_recent, -> { order(created_at: :desc) }
  scope :happen_recent, -> { order(date_time: :asc).where("date_time >= ?", Time.zone.now.beginning_of_day) }
  validates :user_id, presence: true
  validates :date_time, presence: true
  validates :hour, presence: true, numericality: { less_than_or_equal_to: 24 }
  validates :country, presence: true
  validates :city, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
