class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :availability
  has_one :artist, through: :availability, source: :artist

  before_validation :calculate_end_date

  def calculate_end_date
    end_date = start_date + duration.hours
  end
end
