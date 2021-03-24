class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :artist

  validates :rating, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5} 
  validates :comment, length: {maximum: 300}
end
