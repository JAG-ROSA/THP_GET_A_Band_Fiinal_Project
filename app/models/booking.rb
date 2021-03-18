class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  before_validation :calculate_end_date

  after_create :customer_request, :artist_request
  after_update :customer_confirmation
  # after_destroy :customer_cancellation
  
  def customer_request
    BookingMailer.customer_request(self).deliver_now
  end

  def artist_request
    BookingMailer.artist_request(self).deliver_now
  end

  def customer_confirmation
    BookingMailer.customer_confirmation(self).deliver_now
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

  def start_time
    self.start_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
