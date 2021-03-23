class StaticPagesController < ApplicationController
  def index
    @sample_artists = Artist.all.sample(3)
  end
end
