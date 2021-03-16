class DashboardController < ApplicationController
  def index
    @bookings = current_artist.bookings
  end
end
