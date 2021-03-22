class Category < ApplicationRecord
  validates :label, length: { in: 0..50 },
                    uniqueness: true
end
