FactoryBot.define do
  factory :favourite do
    association :user
    association :review
  end
end