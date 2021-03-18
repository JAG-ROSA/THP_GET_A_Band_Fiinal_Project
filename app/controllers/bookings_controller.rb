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
    @booking = Booking.new(start_date: params[:start_date], duration: 24, description: params[:description], user_id: current_user.id, artist_id: params[:artist_id])

    if @booking.save
      # redirect_to checkout_create_path
      redirect_to root_path, success: "Booking well created!"
    else
      redirect_back fallback_location: root_path, danger: "Something went wrong, please retry!"
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
    flash[:danger] = "Réservation annulée"
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def show
  end
end
