class Category < ApplicationRecord
  validates :category, length: { in: 0..50 }
end
