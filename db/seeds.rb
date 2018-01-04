# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
email = "consultant1@sample.com"
password = "password"
name = Faker::Name.name
uid = User.create_unique_string
User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Consultant',
               user_type: 'Consultant'
               )

email = "client1@sample.com"
password = "password"
name = Faker::Name.name
uid = User.create_unique_string
User.create!(email: email,
              password: password,
              password_confirmation: password,
              name: name,
              confirmed_at: Time.now,
              confirmation_sent_at: Time.now,
              type: 'Client',
              user_type: 'Client'
              )

9.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  uid = User.create_unique_string
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               confirmed_at: Time.now,
               confirmation_sent_at: Time.now,
               type: 'Consultant',
               user_type: 'Consultant'
               )
end

9.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  uid = User.create_unique_string
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
