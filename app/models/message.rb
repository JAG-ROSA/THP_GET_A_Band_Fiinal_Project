class Message < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :conversation
end
