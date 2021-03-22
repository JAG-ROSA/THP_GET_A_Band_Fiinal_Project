class ConversationsController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = Booking.all.where(user_id: current_user, status: "approved")
    @artists = Booking.all.where(artist_id: current_artist, status: "approved")
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

  def show

  end

  def create
    if user_signed_in?
      @conversation = Conversation.get(current_user.id, params[:artist_id])
    elsif artist_signed_in?
      @conversation = Conversation.get(params[:artist_id], current_artist.id)
    end
    
    add_to_conversations if conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    Conversation.create(@conversation.id)
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
