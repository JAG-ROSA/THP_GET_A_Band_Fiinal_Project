class RemoveAdminAndArtistChat < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admin, :boolean
    remove_reference :messages, :artist
  end
end
