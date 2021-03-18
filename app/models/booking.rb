class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  before_validation :calculate_end_date

  after_update :booking_tracking
  # after_destroy :customer_cancellation

  def booking_tracking
    if self.status == "approved"
      BookingMailer.customer_confirmation(self).deliver_now
    end
    if self.status == "pending"
      BookingMailer.artist_request(self).deliver_now
      BookingMailer.customer_request(self).deliver_now
    end
  end

  def customer_cancellation
    BookingMailer.customer_cancellation(self).deliver_now
  end

  def calculate_end_date
    end_date = start_date + duration.hours
  end

  def total_price
    return self.duration * self.artist.hourly_price
  end
end
