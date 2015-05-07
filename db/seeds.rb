require 'faker'

5.times do
  User.create(username: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password(8))
end

User.all.each do |user|
  Connection.create(follower_id: user.id, followee_id: User.all.sample.id)
end
