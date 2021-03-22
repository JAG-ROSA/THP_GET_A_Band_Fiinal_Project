class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :location, optional: true

  has_many :availabilities, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_many :artist_categories
  has_many :categories, through: :artist_categories

  validates :artist_name, length: { maximum: 30 }
  validates :description, length: { maximum: 1000 }
  validates :hourly_price, numericality: { allow_nil: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 300 }

  scope :approved, -> { where(status: "approved") }

  after_create :welcome_email_artist

  def welcome_email_artist
    UserMailer.new_artist(self).deliver_now
  end
end
