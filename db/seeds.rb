require 'faker'

10.times do
  User.create(username: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password(8))
end

User.all.each do |user|
  followed_users = User.all.sample(5)
  followed_users.each do |followee|
    Connection.create(follower_id: user.id, followee_id: followee.id)
  end
end
