class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def create
    @booking = Booking.find(params[:booking_id])
    @user = current_user
    @total = @booking.total_price
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: @user.email,
      line_items: [
        {
          name: "Get a Band Stripe Checkout",
          amount: (@total * 100).to_i,
          currency: "eur",
          quantity: 1
        },
      ],
      success_url: checkout_index_url + "?booking_id=#{@booking.id}" + "&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url,
    )
    respond_to do |format|
      format.js
    end
  end
  def index
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    payment_id = @payment_intent.id
    @booking = Booking.find(params[:booking_id])
    @booking.update(stripe_customer_id: payment_id, status:"pending")
  end
end
