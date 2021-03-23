class AvatarsController < ApplicationController
  def create
    @artist = current_artist
    @artist.avatar.attach(params[:avatar])    
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Profile Picture well added!"      
  end
end
