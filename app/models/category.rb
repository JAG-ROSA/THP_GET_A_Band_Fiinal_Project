class Category < ApplicationRecord
  has_many :artist_categories
  has_many :artists, through: :artist_categories

  validates :label, length: { in: 0..50 },
                    uniqueness: true
end
