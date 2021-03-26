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

  validates :playlist, length:{maximum: 100}, if: :valid_playlist_link? , on: :update
  validates :avatar, limit: {max: 1} , content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 1500.kilobytes }
  validates :pictures, limit: {max: 4} , content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 1500.kilobytes }


  has_one_attached :avatar
  has_many_attached :pictures

  has_many :messages
  has_many :conversations, foreign_key: :recipient_id
  has_many :reviews

  scope :approved, -> { where(status: "approved") }

  after_create :welcome_email_artist, if: -> { Rails.env.production? }
  after_update :artist_approval_email

  def welcome_email_artist
    UserMailer.new_artist(self).deliver_now
  end

  def artist_approval_email
    if self.status == "approved"
      UserMailer.approved_artist(self).deliver_now
    end
  end

  def valid_playlist_link?
    if !self.playlist.blank?
      errors.add(:playlist, "le lien de la playlist n'est pas au bon format") unless self.playlist.strip.start_with?("https://open.spotify.com/")
    end
  end
end
