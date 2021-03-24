class ConversationsController < ApplicationController

  before_action :assert_artist_or_user_signed_in
  
  def index
    session[:conversations] ||= []

    @users = Booking.all.where(user_id: current_user, status: "approved")
    @artists = Booking.all.where(artist_id: current_artist, status: "approved")
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

  def create
    if user_signed_in?
      @conversation = Conversation.get(current_user.id, params[:user_id])
    elsif artist_signed_in?
      @conversation = Conversation.get(params[:user_id], current_artist.id)
    end
    
    add_to_conversations if conversated?

    respond_to do |format|
      format.js
    end
  end

  def destroy
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

  def assert_artist_or_user_signed_in 
    redirect_to user_session_path unless current_user || current_artist 
  end
end
