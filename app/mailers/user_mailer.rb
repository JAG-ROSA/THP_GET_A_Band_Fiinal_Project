class UserMailer < ApplicationMailer
  def new_artist(artist)
    @artist = artist
    mail(to: @artist.email, subject: 'Bienvenue sur Get a Band !') 
  end

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Get a Band !') 
  end
end
