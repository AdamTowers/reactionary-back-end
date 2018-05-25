class User < ApplicationRecord
  belongs_to :room

  validates :username, length: {in: 3..36}
end
