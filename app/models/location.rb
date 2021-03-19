class Location < ApplicationRecord
  has_many :artists
  validates :department, length: {maximum: 20}
end
