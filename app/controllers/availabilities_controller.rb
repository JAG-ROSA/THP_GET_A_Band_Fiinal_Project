class AvailabilitiesController < ApplicationController
  before_action :authenticate_artist!

  def index
    start_date = index_params.fetch(:start_date, Date.today).to_date
    @bookings = current_artist.bookings
    @availabilities = current_artist.availabilities
  end

  def show
  end

  def new
  end

  def create
    @bookings = current_artist.bookings
    @availabilities = current_artist.availabilities
    @availability = Availability.new(start_date: "#{create_params[:start_date]} 00:00:00", artist_id: current_artist.id, end_date: "#{create_params[:end_date]} 23:59:59")
    if @availability.save
      @flash = [["success", "Dates de disponibilités ajoutées"]] 
    else
      @flash = [["danger", "#{@availability.errors.full_messages.join(" ")}"]]
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js { }
    end
  end

  def destroy
    @bookings = current_artist.bookings
    @availabilities = current_artist.availabilities
    @availability = Availability.find(destroy_params[:id])
    @availability.destroy
    flash[:danger] = "Disponibilité détruite"
    redirect_back(fallback_location: root_path)
  end

  private

  def index_params
    params.permit(:start_date)
  end

  def create_params
    params.permit(:start_date, :end_date)
  end

  def destroy_params
    params.permit(:id)
  end
end
