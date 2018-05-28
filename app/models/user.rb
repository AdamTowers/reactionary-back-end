class User < ApplicationRecord
  belongs_to :room

  has_secure_password

  validates :username, length: {in: 3..36}
  validates :username, uniqueness: true
  validates :password, presence: true
end
