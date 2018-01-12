# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

1.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  profile = Faker::University.name

  User.create!(email: 'couns1@tmp.com',
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Consultant',
               user_type: 'Consultant',
               profile: profile
               )
end

9.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  profile = Faker::University.name

  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Consultant',
               user_type: 'Consultant',
               profile: profile
               )
end


1.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  User.create!(email: 'client1@tmp.com',
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Client',
               user_type: 'Client'
               )
end

9.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Client',
               user_type: 'Client'
               )
end
