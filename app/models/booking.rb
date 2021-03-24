class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_one :review 

  before_validation :calculate_end_date

  after_update :booking_tracking
  validate :check_if_artist_is_available, on: [:create]
  validates :description, length: {in: 0..600 }
  validates :duration, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24}

  scope :approved, -> { where(status: "approved") }

  def booking_tracking
    if self.status == "approved"
      BookingMailer.customer_confirmation(self).deliver_now
    elsif self.status == "pending"
      BookingMailer.artist_request(self).deliver_now
      BookingMailer.customer_request(self).deliver_now
    elsif self.status == "cancelled_by_artist"
      BookingMailer.artist_cancellation(self).deliver_now
    elsif self.status == "cancelled_by_user"
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

  def no_late_cancel?
    if self.start_date >= DateTime.now + 1.week
      errors.add(:start_date, "On ne peut modifier une réservation moins d'une semaine à l'avance")
    end
  end

  def try_refund
    if stripe_customer_id.present?
      Stripe::Refund.create(
        {
          payment_intent: stripe_customer_id,
        }
      )
    end
  end

end
