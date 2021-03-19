class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  before_validation :calculate_end_date

  after_update :booking_tracking
  validate :check_if_artist_is_available, on: [:create]
  validates :description, length: {in: 0..600 }
  validates :duration, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24}

  def booking_tracking
    if self.status == "approved"
      BookingMailer.customer_confirmation(self).deliver_now
    end
    if self.status == "pending"
      BookingMailer.artist_request(self).deliver_now
      BookingMailer.customer_request(self).deliver_now
    end
    if self.status == "cancelled_by_artist"
      BookingMailer.customer_cancellation(self).deliver_now
    end
  end

  def calculate_end_date
    self.end_date = start_date + duration.hours
  end

  def total_price
    return self.duration * self.artist.hourly_price
  end

  def start_time
    self.start_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

  def check_if_artist_is_available
    if Availability.available_artists(self.start_date, self.end_date).exclude?(self.artist)
      errors.add(:start_date, "Cet artiste n'est pas disponible pour la date sélectionnée.")
    end
  end

  # def is_booking_approved?
  #   if self.status == "pending"
  #     Booking.
  #   end
  # end
end
