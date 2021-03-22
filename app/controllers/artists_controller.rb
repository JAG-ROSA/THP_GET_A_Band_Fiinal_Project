class ArtistsController < ApplicationController
  before_action :authenticate_artist!, except: [:index, :show]

  def index
    if index_params[:start_date].present?
      @start_at = index_params[:start_date]
      @end_at = @start_at.to_date + 1.day
      @artists = Availability.available_artists(@start_at, @end_at)
    else
      @artists = Artist.approved
      @start_at = Date.current
    end
  end

  def show
    @artist = Artist.find(show_params[:id])
  end

  def create
  end

  def update
    @artist = current_artist
    @artist.artist_name = update_params[:artist_name]
    @artist.description = update_params[:description]
    @artist.hourly_price = update_params[:hourly_price]
    @artist.location_id = update_params[:location]

    if @artist.save
      redirect_to artist_bookings_path(artist_id: @artist.id)
      flash[:success] = "Vos informations ont bien été changées."
    else
      flash[:danger] = "Erreur: " + @artist.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
  end

  def edit
    @artist = current_artist
    @all_locations = Location.all
    @all_categories = Category.all
  end

  private

  def index_params
    params.permit(:start_date)
  end

  def show_params
    params.permit(:id)
  end

  def update_params
    params.require(:artist).permit(:artist_name, :description, :hourly_price, :location)
  end
end
