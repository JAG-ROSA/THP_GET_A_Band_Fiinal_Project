class ArtistsController < ApplicationController
  def index
    if params[:start_date].present?
      @start_at = params[:start_date]
      @end_at = @start_at.to_date + 1.day
      @artists = Availability.available_artists(@start_at, @end_at)
    else
      @artists = Artist.approved
    end
  end

  def show
    @artist = Artist.find_by(id: params[:id])
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
