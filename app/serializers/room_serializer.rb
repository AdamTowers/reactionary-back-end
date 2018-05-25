class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id

  has_many :users
end
