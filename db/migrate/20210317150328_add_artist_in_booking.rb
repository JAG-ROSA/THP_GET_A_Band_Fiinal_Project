class AddArtistInBooking < ActiveRecord::Migration[5.2]
  def change    
    remove_belongs_to(:bookings, :availability, index: true)
    add_belongs_to(:bookings, :artist, index: true)
  end
end
