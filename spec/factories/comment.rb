FactoryBot.define do
  factory :comment do
    association :user
    association :review
  end
end