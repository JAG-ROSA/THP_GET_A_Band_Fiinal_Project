class DashboardController < ApplicationController
  def index
    @bookings = Booking.all.where(artist:current_artist.id)
  end
end
