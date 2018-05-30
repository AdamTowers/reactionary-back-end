class User < ApplicationRecord
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_secure_password
  validates :username, length: {in: 3..36}, uniqueness: true

  def self.digest(password)
    BCrypt::Password.create(password).to_s
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def check_digest(password, hash)
    BCrypt::Password.new(hash) == password
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
