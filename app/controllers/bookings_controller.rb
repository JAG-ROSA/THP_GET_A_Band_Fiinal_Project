class BookingsController < ApplicationController
  def index
    @bookings = current_artist.bookings
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def show
  end
end
