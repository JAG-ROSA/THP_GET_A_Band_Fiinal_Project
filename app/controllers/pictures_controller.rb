class PicturesController < ApplicationController
  def create
    @artist = current_artist
    
    @artist.update(params.require(:artist).permit(pictures:[] ) )   
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well added!"
  end 
end
