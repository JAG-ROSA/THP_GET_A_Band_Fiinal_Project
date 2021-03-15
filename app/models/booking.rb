class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :availability
  has_one :artist, through: :availability, source: :artist
end
