class AddPlaylistToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :playlist, :string,default: "", null: false
  end
end
