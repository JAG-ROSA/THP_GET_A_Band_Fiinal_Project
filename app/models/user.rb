class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings, dependent: :destroy

  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :reviews

  after_create :welcome_email_user, if: -> { Rails.env.production? }

  def welcome_email_user
    UserMailer.new_user(self).deliver_now
  end
end
