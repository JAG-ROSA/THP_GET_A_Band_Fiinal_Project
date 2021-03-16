class Availability < ApplicationRecord
  belongs_to :artist
  has_one :booking
end
