class ArtistsController < ApplicationController
  def index
    @artists = Artist.where(status: "approved")
    #@artists = Availability.available_artists(from: "2021-03-21 15:30:00", to: "2021-03-22 15:30:00")
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
