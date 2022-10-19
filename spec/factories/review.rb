FactoryBot.define do
  factory :review do
    title { "title" }
    content { "content" }

    association :user
  end
end