class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :location, optional: true

  has_many :availabilities, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :artist_name, uniqueness: true, length: {maximum: 30}
  validates :description, length: {in: 0..1000}
  validates :hourly_price, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 300}

  scope :approved, -> { where(status: "approved") }

  after_create :welcome_email_artist

  def welcome_email_artist
    UserMailer.new_artist(self).deliver_now
  end
end
