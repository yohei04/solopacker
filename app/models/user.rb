class User < ApplicationRecord
  has_one_attached :image
  has_many :recruits, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_recruits, through: :participations, source: :recruit
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, uniqueness: true, length: { maximum: 15 }

  def age
    return if date_of_birth.nil?

    (Time.zone.today.strftime('%Y%m%d').to_i - date_of_birth&.strftime('%Y%m%d').to_i) / 10_000
  end

  def commented?(recruit)
    comments.exists?(recruit_id: recruit.id)
  end

  def participated?(recruit)
    participations.exists?(recruit_id: recruit.id)
  end

  def feature_host_recruits
    feature_host_recruits = []
    self.recruits.happen_recent.each do |recruit|
      feature_host_recruits.push(recruit) if recruit.date_time > Time.now
    end
    feature_host_recruits
  end

  def feature_participate_recruits
    feature_participate_recruits = []
    self.participated_recruits.happen_recent.each do |recruit|
      feature_participate_recruits.push(recruit) if recruit.date_time > Time.now
    end
    feature_participate_recruits
  end

  def feature_mix_recruits
    feature_host_recruits.concat(feature_participate_recruits).sort_by! { |r| r[:date_time] }
  end

  def uniq_feature_mix_recruits
    feature_mix_recruits.uniq { |r| r[:country] }
  end
end
