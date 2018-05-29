# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = []
5.times do
  users << User.create(username: Faker::Internet.user_name(5..8), password: 'password1')
end
# pw: min 8
room1 = Room.create(name: 'room1', user_id: users[0].id)

i = 0
4.times do
  UserRoom.create(user_id: users[i].id, room_id:room1.id)
  i+=1
end

Word.create(content: 'dinosaur')
Word.create(content: 'apple')
Word.create(content: 'cat')
Word.create(content: 'dog')
Word.create(content: 'pikachu')
Word.create(content: 'cellphone')
Word.create(content: 'broccoli')
Word.create(content: 'fireman')
