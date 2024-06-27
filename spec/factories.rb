require 'faker'
FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    username {Faker::Internet.username }
    name { Faker::Internet.name }
    password { Faker::Internet.password }
  end
end