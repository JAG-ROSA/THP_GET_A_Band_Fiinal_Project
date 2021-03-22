class PicturesController < ApplicationController
  def create
    @artist = current_artist
    @artist.pictures.attach(params[:pictures] )   
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well added!"
  end 

  def destroy
    @picture = ActiveStorage::Attachment.find(params[:id])
    @picture.purge
  end
end
