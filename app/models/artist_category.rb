class ArtistCategory < ApplicationRecord
  belongs_to :artist
  belongs_to :category

  validate :set_categories_quota_per_artist

  def set_categories_quota_per_artist
    unless ArtistCategory.where(artist_id: artist.id).size < 3
      errors.add(:category, "Vous ne pouvez pas sélectionner plus de 3 labels.")
    end
  end
end
