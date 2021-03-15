class UsersController < ApplicationController
  def index
  end

  def show
    @user = helpers.current_user
  end

  def create
  end

  def update
  end

  def destroy
  end
end
