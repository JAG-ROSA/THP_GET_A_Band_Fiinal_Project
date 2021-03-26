class UserMailer < ApplicationMailer
  def new_artist(artist)
    @artist = artist
    @url = 'https://get-a-band.herokuapp.com/'
    mail(to: @artist.email, subject: 'Bienvenue sur Get a Band !') 
  end

  def approved_artist(artist)
    @artist = artist
    @url = 'https://get-a-band.herokuapp.com/'
    mail(to: @artist.email, subject: 'Profil accepté sur Get a Band !') 
  end

  def new_user(user)
    @user = user
    @url = 'https://get-a-band.herokuapp.com/'
    mail(to: @user.email, subject: 'Bienvenue sur Get a Band !') 
  end
end
