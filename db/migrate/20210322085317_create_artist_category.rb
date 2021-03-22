class CreateArtistCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :artists_categories do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end
