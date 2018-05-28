class User < ApplicationRecord
  belongs_to :room

  has_secure_password

  validates :username, length: {in: 3..36}, uniquness: true
  validates :password, presence: true
end
