class StageImagesController < ApplicationController
  def create
    @artist = current_artist
    @artist.stage_images.attach(params[:stage_images])    
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well added!"
  end  
end
