# frozen_string_literal: true

FactoryBot.define do
  factory :taxonomy do
    sequence(:title) { |n| "Taxonomy##{n}" }
    editor
  end
end
