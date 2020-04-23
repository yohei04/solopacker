class Recruit < ApplicationRecord
  include Scope
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user
  scope :happen_recent, -> { order(date_time: :desc) }
  scope :feature, -> { where('date_time >= ?', Time.zone.now.beginning_of_day) }
  scope :upcoming, -> { order(date_time: :asc).feature }
  scope :popular_countries, -> { group("country").feature.order('count_country desc').count('country').keys }
  validates :user_id, presence: true
  validates :date_time, presence: true
  validates :hour, presence: true, numericality: { less_than_or_equal_to: 24 }
  validates :country, presence: true
  validates :city, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
