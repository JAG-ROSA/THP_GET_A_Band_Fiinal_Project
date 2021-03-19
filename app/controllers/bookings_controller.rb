class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy, :index, :update]
  before_action :authenticate_artist!, only: [:index, :update]

  def index
    @bookings = current_artist.bookings
  end

  def new
    @artist = Artist.find_by(id: params[:artist_id])
    if params[:start_date] != nil
      @start_date = params[:start_date]
    else
      @start_date = DateTime.current.to_date
    end
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

    if current_artist
      if @booking.no_late_cancel?
        @booking.update(status: "cancelled_by_artist")
        if !@booking.stripe_customer_id.nil?
          Stripe::Refund.create({
            payment_intent: @booking.stripe_customer_id,
          })
        end
        flash[:success] = "Réservation annulée"
        redirect_to artist_bookings_path(artist_id: current_artist.id)
      else
        flash[:danger] = "Il est trop tard pour annuler cette réservation."
        redirect_to artist_bookings_path(artist_id: current_artist.id)
      end      
    else
      if @booking.status == "payment_pending"
        @booking.destroy
        flash[:success] = "Demande de réservation annulée"
        redirect_to artists_path
      else
        if @booking.no_late_cancel?
          @booking.update(status: "cancelled_by_user")
          if !@booking.stripe_customer_id.nil?
            Stripe::Refund.create({
              payment_intent: @booking.stripe_customer_id,
            })
          end
          flash[:success] = "Réservation annulée"
          redirect_to current_user
        else
          flash[:danger] = "Il est trop tard pour annuler cette réservation."
          redirect_to current_user
        end 
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
end
