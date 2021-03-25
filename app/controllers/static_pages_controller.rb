class StaticPagesController < ApplicationController
  def index
    @sample_artists = Artist.approved.sample(3)
  end
end
