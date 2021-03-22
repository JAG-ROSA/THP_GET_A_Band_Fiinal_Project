class ConversationsController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations].first)
  end

  def show

  end

  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    
    add_to_conversations if conversated?

    respond_to do |format|
      format.js{}
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
