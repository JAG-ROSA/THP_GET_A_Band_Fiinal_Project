class ArtistsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @artists = Artist.all
  end

  def show
  end

  def create
  end

  def update
    @artist = current_artist
    @artist.artist_name = params[:artist_name]
    @artist.description = params[:description]
    @artist.hourly_price = params[:hourly_price]
    @artist.location = Location.find(params[:location])

    if @artist.save
      redirect_to artist_bookings_path(artist_id: @artist.id)
      flash[:success] = "Your information has been udpated."
    else
      flash[:danger] = "Erreur : " + @artist.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
  end

  def edit
    @artist = current_artist
    @all_locations = Location.all
  end
end
