class Room < ApplicationRecord
  has_many :users

  validates :name, length: {in: 3..36}
end
