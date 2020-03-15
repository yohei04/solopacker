class Recruit < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :joined_users, through: :joins, source: :user
  scope :recent, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :date_time, presence: true
  validates :hour, presence: true, numericality: { less_than_or_equal_to: 24 }
  validates :country, presence: true
  validates :city, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
