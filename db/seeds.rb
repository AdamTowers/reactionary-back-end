# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
room1 = Room.create(name: 'room1')

users = []
5.times do
  users << User.create(username: Faker::Internet.user_name(5..8), password_digest: 'password1', room: 1)
end

Word.create(content: 'dinosaur')
Word.create(content: 'apple')
Word.create(content: 'cat')
Word.create(content: 'dog')
Word.create(content: 'pikachu')
Word.create(content: 'cellphone')
Word.create(content: 'broccoli')
Word.create(content: 'fireman')
