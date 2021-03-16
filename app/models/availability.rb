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
end
