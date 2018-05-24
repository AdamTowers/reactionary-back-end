class CreateUserRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :user_rooms do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
    end
  end
end
