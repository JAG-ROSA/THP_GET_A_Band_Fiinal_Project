class CheckoutController < ApplicationController
  def create
    @booking = Booking.new(start_date: params[:start_date], duration: 24, description: params[:description], user_id: current_user.id, artist_id: params[:artist_id], status: "payment_pending")
    if @booking.save!
      @user = current_user
      @total = @booking.total_price
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        line_items: [
          {
            name: "Get a Band Stripe Checkout",
            amount: (@total * 100).to_i,
            currency: "eur",
            quantity: 1,
          },
        ],
        success_url: checkout_index_url + "?booking_id=#{@booking.id}" + "&session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url,
      )
      respond_to do |format|
        format.js
      end
    else
      redirect_back fallback_location: root_path, danger: "Something went wrong, please retry!"
    end
  end
  def index
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @booking = Booking.find(params[:booking_id])
    @booking.update(status:"pending")
  end
end
