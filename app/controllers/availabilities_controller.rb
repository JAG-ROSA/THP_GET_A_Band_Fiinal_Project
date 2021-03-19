class AvailabilitiesController < ApplicationController
  before_action :authenticate_artist!
  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @bookings = current_artist.bookings
    @availabilities = current_artist.availabilities
  end

  def show
  end

  def new
    
  end

  def create
    @availability = Availability.new(start_date: "#{params[:start_date]} 00:00:00", artist_id: current_artist.id, end_date: "#{params[:end_date]} 23:59:59")
    if @availability.save
      flash[:success] = "Dates de disponibilités ajoutées"
    else
      flash[:danger] = "Impossible de créer une disponibilité si la date est déjà disponible"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy
    flash[:danger] = "Disponibilité détruite"
    redirect_back(fallback_location: root_path)
  end

  
  

end
