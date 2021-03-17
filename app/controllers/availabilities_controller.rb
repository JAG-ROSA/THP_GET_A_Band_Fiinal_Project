class AvailabilitiesController < ApplicationController
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
    @availability = Availability.new(start_date: params[:start_date], artist_id: current_artist.id, end_date: params[:end_date])
     @availability.save
      redirect_back(fallback_location: root_path)
  end
end
