FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      name { "admin" }
      email { "admin@example.com" }
      password { "admin_password" }
      password_confirmation { "admin_password" }
    end
  end
end