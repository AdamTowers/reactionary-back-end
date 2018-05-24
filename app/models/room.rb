class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms

  validates :name, length: {in: 3..36}
end
