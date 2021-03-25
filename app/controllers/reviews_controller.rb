class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :new, :create, :update]
  before_action :set_artist, only: [:new, :create]
  before_action :set_booking, only: [:new, :create]
  def index
  end

  def new    
    @already_review = Review.where(user_id: current_user.id, booking_id:params[:booking_id], artist_id: params[:artist_id]).first
    if @already_review.present? && current_user
      flash[:danger] = "Vous n'avez pas accès à cette évaluation"
      redirect_to root_path
    end
    @note = [1,2,3,4,5]
  end

  def create
    @review = Review.new(rating: params[:rating], comment: params[:comment],user_id: current_user.id, artist_id: params[:artist_id], booking_id: params[:booking_id])

    if @review.save
      redirect_to current_user, success: "Merci pour votre retour"
    else
      flash.now[:danger] = "erreur "+ @review.errors.full_messages.join(" ")
      render :new
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def set_artist
    @artist = Artist.find(params[:artist_id])
  end
  
  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.permit(:rating, :comment, :user_id, :artist_id, :booking_id)    
  end

  def involved_user
    current_user == @booking.user && !@booking.review.exists?    
  end

end
