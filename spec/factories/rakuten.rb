FactoryBot.define do
  factory :rakuten do
    sequence(:name) { |n| "rakuten_name_#{n}"}
    sequence(:url) { |n| "rakuten_url_#{n}"}
    sequence(:image) { |n| "rakuten_image_#{n}"}
  end
end