class User < ApplicationRecord
  has_one_attached :image
  has_many :recruits, dependent: :destroy
  has_many :comments, dependent: :destroy
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
end
