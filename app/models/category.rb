class Category < ApplicationRecord
  has_many :category_artists
  has_many :artists, through: :category_artists

  validates :label, length: { in: 0..50 },
                    uniqueness: true
end
