# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# The admin
User.create(
  name: "Hani",
  email: "inahmarie.sanjuan@framgia.com",
  password: "password",
  admin: true
)

50.times do |n|
  User.create(
    name: Faker::Pokemon.name,
    email: "example-#{n+1}@railstutorial.org",
    password: "password"
  )
end

users = User.take(6)
# Generate 20 microposts to each user

20.times do
  content = Faker::Lorem.sentence(5)

  users.each { |user|  user.microposts.create(content: content) }
end

# To add following data
users = User.all
user = User.first
followers = users[2..50]
following = users[3..40]

followers.each { |follower| follower.follow(user) }
following.each { |followed| user.follow(followed) }

microposts = Micropost.take(25)

microposts.each do |micropost| 
  followers.each { |follower| follower.upvote(micropost) }
end
