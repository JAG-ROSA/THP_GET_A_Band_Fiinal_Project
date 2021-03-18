class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :location, optional: true

  has_many :availabilities
  has_many :bookings

  has_one_attached :avatar
  has_many_attached :stage_images

  scope :approved, -> { where(status: "approved") }
end
