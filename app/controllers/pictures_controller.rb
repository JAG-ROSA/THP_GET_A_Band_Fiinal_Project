class PicturesController < ApplicationController
  before_action :set_artist, only: [:create, :destroy]

  def create
    @artist.pictures.attach(params[:pictures] )   
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well added!"
  end 

  def destroy
    @picture = ActiveStorage::Attachment.find(params[:id])
    if @picture.purge
      redirect_to artist_bookings_path(artist_id: @artist.id), success: "Picture well deleted!"
    else
      flash[:danger] = "Something went wrong"
    end
  end

  private
  def set_artist
    @artist = current_artist    
  end
end
