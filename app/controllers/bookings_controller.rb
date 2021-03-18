class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @bookings = current_artist.bookings
    @artist = current_artist
  end

  def new
    @artist = Artist.find_by(id: params[:artist_id])
    @start_date = params[:start_date]
  end

  def create
    @booking = Booking.new(start_date: params[:chosen_start_date], duration: 24, description: params[:description], user_id: current_user.id, artist_id: params[:artist_id], status: "payment_pending")
    if @booking.save
      redirect_to artist_booking_path(artist_id:@booking.artist.id, id: @booking.id)
    else
      flash[:danger] = "L'artiste n'est pas disponible à cette date."
      redirect_back fallback_location: artist_path(@booking.artist.id)
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status: "approved")
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    if current_artist
      flash[:danger] = "Réservation annulée"
      redirect_to artist_bookings_path(artist_id: current_artist.id)      
    else
      flash[:danger] = "Demande de réservation annulée"
      redirect_to artists_path
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end
end
