class CheckoutController < ApplicationController
  def create
    @user = current_user
    # A changer
    # booking_id = params[:booking_id].to_i
    # @total = Booking.find(session[:booking_id]).total
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
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
    )
    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
  end
end
