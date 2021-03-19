class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :location, optional: true

  has_many :availabilities
  has_many :bookings

  scope :approved, -> { where(status: "approved") }

  after_create :welcome_email_artist

  def welcome_email_artist
    UserMailer.new_artist(self).deliver_now
  end
end
