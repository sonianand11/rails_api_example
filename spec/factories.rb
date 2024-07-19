require 'faker'
FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user { nil }
    commentable { nil }
  end

  factory :post do
    title { "MyString" }
    description { "MyString" }
    user { nil }
  end

  factory(:user) do
    email { Faker::Internet.email }
    username {Faker::Internet.username }
    name { Faker::Internet.name }
    password { Faker::Internet.password }
  end
end