FactoryBot.define do
  factory :review do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:content) { |n| "content_#{n}" }

    association :user

    trait :cainz_nekojarashi do
      transient do
        sequence(:name) { |n| "cainz_nekojarashi_#{n}"}
        sequence(:url) { |n| "cainz_nekojarashi_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        nekojarashi_category = Category.find(1)
        cainz = create(:cainz, name: evaluator.name, url: evaluator.url)
        nekojarashi_category.cainzs << cainz
        review.save_with_product(product_id: cainz.id, product_type: "Cainz")
      end
    end

    trait :rakuten_kerigurumi do
      transient do
        sequence(:name) { |n| "rakuten_name_#{n}"}
        sequence(:url) { |n| "rakuten_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        kerigurumi_category = Category.find(3)
        rakuten = create(:rakuten, name: evaluator.name, url: evaluator.url)
        kerigurumi_category.rakutens << rakuten
        review.save_with_product(product_id: rakuten.id, product_type: "Rakuten")
      end
    end
  end
end