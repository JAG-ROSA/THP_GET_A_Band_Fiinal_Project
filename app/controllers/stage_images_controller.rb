class StageImagesController < ApplicationController
  def create
    @artist = current_artist
    p "test"
    p @artist
    p params
    @artist.update(params.require(:artist).permit(stage_images:[] ) )   
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well added!"
  end  
end
