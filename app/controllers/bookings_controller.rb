class BookingsController < ApplicationController
  def index
    @booking = current_artist.bookings
  end

  def new
    @artist = Artist.find_by(id:params[:artist_id])
  end

  def create
    @booking = Booking.new(start_date: params[:start_date],duration: params[:duration], end_date: params[:end_date],
      availability_id: params[:availability_id])

    if @booking.save
      redirect_to 
    else
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status:"approved")
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
