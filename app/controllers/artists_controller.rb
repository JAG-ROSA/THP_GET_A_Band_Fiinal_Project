class ArtistsController < ApplicationController
  def index
    @artists = Artist.where(status: "approved")
    #@artists = Availability.available_artists("2021-06-25 15:30:00".to_datetime, "2021-06-26 15:30:00".to_datetime)
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
