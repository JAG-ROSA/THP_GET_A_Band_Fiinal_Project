class ArtistsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @artists = Artist.all
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
