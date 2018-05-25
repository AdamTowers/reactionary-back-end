class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms
  belongs_to :host, foreign_key: "user_id", class_name: "User"

  validates :name, length: {in: 3..36}
end
