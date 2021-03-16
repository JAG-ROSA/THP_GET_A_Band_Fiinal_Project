class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :availability
  has_one :artist, through: :availability, source: :artist

  def total_price
    return self.duration * self.artist.hourly_price
  end
end
