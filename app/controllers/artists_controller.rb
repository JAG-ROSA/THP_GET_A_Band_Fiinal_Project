class ArtistsController < ApplicationController
  before_action :authenticate_artist!, except: [:index, :show]
  before_action :set_artist, only: [:edit, :update]

  def index
    @artists = Artist.approved
    #@start_at = Date.current
    @all_categories = Category.all

    if index_params[:start_date].present?
      @start_at = index_params[:start_date]
      @end_at = @start_at.to_date + 1.day
      @artists = Availability.available_artists(@start_at, @end_at)
    end

    if index_params[:categories].present?
      @artists = @artists.joins(:artist_categories)
        .where("category_id IN (?)", index_params[:categories])
        .group("artists.id")
        .having("count(*) >= (?)", index_params[:categories].size)
    end
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def show
    @artist = Artist.find(show_params[:id])
    if !@artist.playlist.blank?
      # All the whitespaces are deleted from the user playlist link
      # then the link is updated to match the widget embed pattern link by inserting "embed/" at the link
      @spotify_playlist = @artist.playlist.strip.insert(25,"embed/")
    else
      @spotify_playlist = ""
    end  
    @availabilities = @artist.availabilities
    @bookings = @artist.bookings
  end

  def create
  end

  def update
    if update_params[:categories].present?
      ArtistCategory.where(artist: @artist).destroy_all

      ArtistCategory.transaction do
        update_params[:categories].each do |category|
          ArtistCategory.create!(category_id: category.to_i, artist: @artist)
        end
      rescue StandardError => error
        flash[:danger] = error.message
      end
    end

    if @artist.update(update_params.except(:categories))
      redirect_to artist_bookings_path(artist_id: @artist.id)
      flash[:success] = "Vos informations ont bien été changées."
    else
      @all_locations = Location.all
      @all_categories = Category.all
      flash[:danger] = "Erreur: " + @artist.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
  end

  def edit
    @all_locations = Location.all
    @all_categories = Category.all
  end

  private

  def set_artist
    @artist = current_artist
  end

  def index_params
    params.permit(:start_date, categories: [])
  end

  def show_params
    params.permit(:id)
  end

  def update_params
    params.require(:artist).permit(:artist_name, :description, :hourly_price, :location_id, :playlist, :avatar, pictures: [], categories: [])
  end
end
