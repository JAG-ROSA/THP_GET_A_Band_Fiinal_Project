class Availability < ApplicationRecord
  belongs_to :artist

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
    Booking.where("start_date <= (?) AND end_date >= (?)", start_requested_date, end_requested_date).pluck(:artist_id)
  end

  def self.available_artists(start_requested_date, end_requested_date)
    artists_with_availabilities = has_availabilities(start_requested_date, end_requested_date)
    artists_with_bookings = has_bookings(start_requested_date, end_requested_date)

    available_artists = artists_with_availabilities - artists_with_bookings
    Artist.where(id: available_artists).approved
  end

  #Methods to see if two dates overlap
  scope :overlaps, ->(start_date, end_date) do
    where "((start_date <= ?) and (end_date >= ?))", end_date, start_date
  end

  def overlaps?
    overlaps.exists?
  end

  # Compare the dates with the siblings
  def overlaps
    siblings.overlaps start_date, end_date
  end

  validate :not_overlap
  # If there is an overlaps send and error
  def not_overlap
    errors.add(:key, 'message') if overlaps?
  end

  # Method to keep only the availabilities for the same artist
  def siblings
    Availability.where('artist_id = ?', artist_id || -1)
  end
end
