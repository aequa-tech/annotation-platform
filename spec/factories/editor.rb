# frozen_string_literal: true

FactoryBot.define do
  factory :editor do
    fullname { "John Doe" }
    sequence(:email) { |n| "editor##{n}@example.com" }
    password { "password" }
  end
end
