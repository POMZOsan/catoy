FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "content_#{n}"}
    association :user
    association :review
  end
end