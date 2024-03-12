FactoryBot.define do
  factory :annotation do
    text_line
    annotator
    content { JSON.generate({}) }
  end
end
