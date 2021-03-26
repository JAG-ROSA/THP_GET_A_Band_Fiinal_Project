class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy, :index, :update]
  before_action :authenticate_artist!, only: [:index, :update]
  before_action :is_user_profile_complete?, on: [:new, :create]

  def index
    @bookings = current_artist.bookings
    @artist = current_artist
    @reviews = Review.where(artist_id: @artist.id)
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
    @artist = Artist.find(params[:artist_id])
    @start_date = create_params[:start_date]
    @booking = Booking.new(start_date: create_params[:start_date], duration: 24, description: create_params[:description], user_id: current_user.id, artist_id: params[:artist_id], status: "payment_pending")
    if @booking.save
      redirect_to artist_booking_path(artist_id: @booking.artist.id, id: @booking.id)
    else
      flash.now[:danger] = "L'artiste n'est pas disponible à cette date."
      render :new, locals: { description: create_params[:description] }
    end
  end

  def update
    @artist = current_artist
    @bookings = current_artist.bookings
    @booking = Booking.find(update_params[:id])
    @booking.update(status: "approved")
    @flash = [["success", "Réservation confirmée"]]
    respond_to do |format|
      format.html { redirect_to artist_bookings_path(artist_id: current_artist.id) }
      format.js { }
    end
  end

  def destroy
    @booking = Booking.find(destroy_params[:id])

    if current_artist
      cancel_booking_artist(@booking)
    else
      if @booking.status == "payment_pending"
        @booking.destroy
        flash[:success] = "Demande de réservation annulée"
        redirect_to artists_path
      else
        cancel_booking_user(@booking)
      end
    end
  end

  def show
    @booking = Booking.find(params[:id])
    if involved_user(@booking)
    else
      flash[:danger] = "Vous n'avez pas accès à cette réservation."
      redirect_to root_path
    end
  end

  private

  def involved_user(booking)
    current_user == booking.user
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

  def cancel_booking_artist(booking)
    if booking.no_late_cancel?
      booking.update(status: "cancelled_by_artist")
      booking.try_refund
      flash[:success] = "Réservation annulée"
    else
      flash[:danger] = "Il est trop tard pour annuler cette réservation."
    end
    redirect_to artist_bookings_path(artist_id: current_artist.id)
  end

  def cancel_booking_user(booking)
    if booking.no_late_cancel?
      booking.update(status: "cancelled_by_user")
      booking.try_refund
      flash[:success] = "Réservation annulée"
    else
      flash[:danger] = "Il est trop tard pour annuler cette réservation."
    end
    redirect_to current_user
  end

  def is_user_profile_complete?
    if current_user && (current_user.first_name.blank? || current_user.last_name.blank?)
      redirect_to user_path(current_user.id)
    end
  end
end
