class User < ApplicationRecord
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validates :username, length: {in: 3..36}
end
