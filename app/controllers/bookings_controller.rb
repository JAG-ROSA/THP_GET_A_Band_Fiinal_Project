class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @bookings = current_artist.bookings
  end

  def new
    @artist = Artist.find_by(id: params[:artist_id])
    @start_date = params[:start_date]
  end

  def create
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status: "approved")
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:danger] = "Réservation annulée"
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def show
  end
end
