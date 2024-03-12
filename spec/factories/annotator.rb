FactoryBot.define do
  factory :annotator do
    fullname { "Emma Stone" }
    sequence(:email) { |n| "annotator##{n}@example.com" }
    password { "password" }
  end
end
