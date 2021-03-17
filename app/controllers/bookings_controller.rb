class BookingsController < ApplicationController
  def index
    @booking = current_artist.bookings
  end

  def new
    @artist = Artist.find_by(id:params[:artist_id])
    @booking
  end

  def create
    @booking = Booking.new(start_date: params[:start_date], duration: 24, user_id: current_user.id, availability_id: )

    if @booking.save!
      # redirect_to checkout_create_path
      redirect_to root_path
    else
      redirect_back fallback_location: root_path
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
