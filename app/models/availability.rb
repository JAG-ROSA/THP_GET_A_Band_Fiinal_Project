class Availability < ApplicationRecord
  belongs_to :artist
  has_one :booking

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_prior_to_end_date

  def start_prior_to_end_date
    errors.add(:start_date, "must be before end date") unless
      start_date < end_date
  end

  def self.has_availabilities(start_requested_date, end_requested_date)
    # List all the artists who filled out an availibility on the requested period.
    Availability.where("start_date <= (?) AND end_date >= (?)", start_requested_date, end_requested_date).pluck(:artist_id)
  end

  def self.has_bookings(start_requested_date, end_requested_date)
    # List all the artists who have a booking on the requested period.
    Booking.where("start_date <= (?) AND end_date >= (?)", start_requested_date, end_requested_date)
      .map { |booking| booking&.availibility&.artist_id }
  end

  def self.available_artists(start_requested_date, end_requested_date)
    artists_with_availabilities = has_availabilities(start_requested_date, end_requested_date)
    artists_with_bookings = has_bookings(start_requested_date, end_requested_date)

    available_artists = artists_with_availabilities - artists_with_bookings
    available_artists.map! { |artist_id| Artist.find(artist_id) }
    return available_artists
  end
end
