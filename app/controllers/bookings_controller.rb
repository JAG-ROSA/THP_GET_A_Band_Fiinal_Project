class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy, :index, :update]
  before_action :authenticate_artist!, only: [:index, :update]

  def index
    @bookings = current_artist.bookings
  end

  def new
    @artist = Artist.find(new_params[:artist_id])
    if new_params[:start_date] != nil
      @start_date = new_params[:start_date]
    else
      @start_date = DateTime.current.to_date
    end
  end

  def create
    @booking = Booking.new(start_date: create_params[:start_date], duration: 24, description: create_params[:description], user_id: current_user.id, artist_id: params[:artist_id], status: "payment_pending")
    if @booking.save
      redirect_to artist_booking_path(artist_id: @booking.artist.id, id: @booking.id)
    else
      flash[:danger] = "L'artiste n'est pas disponible à cette date."
      redirect_back fallback_location: artist_path(@booking.artist.id)
    end
  end

  def update
    @booking = Booking.find(update_params[:id])
    @booking.update(status: "approved")
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def destroy
    @booking = Booking.find(destroy_params[:id])
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
    if is_involved
      @booking = Booking.find(params[:id])
    else
      flash[:danger] = "Vous n'avez pas accès à cette réservation."
      redirect_to root_path
    end
  end

  private

  def is_involved
    @booking = Booking.find(params[:id])
    current_user == @booking.user
  end

  def new_params
    params.permit(:artist_id, :start_date)
  end

  def create_params
    params.permit(:start_date, :description)
  end

  def update_params
    params.permit(:id)
  end

  def destroy_params
    params.permit(:id)
  end
end
