class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :availability
  has_one :artist, through: :availability, source: :artist

  before_validation :calculate_end_date

  def calculate_end_date
    end_date = start_date + duration.hours
  end

  def total_price
    return self.duration * self.artist.hourly_price
  end

  def start_time
    self.start_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
