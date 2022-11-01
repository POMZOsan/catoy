FactoryBot.define do
  factory :cainz do
    sequence(:name) { |n| "cainz_name_#{n}"}
    sequence(:url) { |n| "cainz_url_#{n}"}
    sequence(:image) { |n| "cainz_image_#{n}"}
  end
end