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

    trait :cainz_nezumi do
      transient do
        sequence(:name) { |n| "cainz_nezumi_#{n}"}
        sequence(:url) { |n| "cainz_nezumi_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        nezumi_category = Category.find(2)
        cainz = create(:cainz, name: evaluator.name, url: evaluator.url)
        nezumi_category.cainzs << cainz
        review.save_with_product(product_id: cainz.id, product_type: "Cainz")
      end
    end

    trait :rakuten_kerigurumi do
      transient do
        sequence(:name) { |n| "rakuten_kerigurumi_#{n}"}
        sequence(:url) { |n| "rakuten_kerigurumi_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        kerigurumi_category = Category.find(3)
        rakuten = create(:rakuten, name: evaluator.name, url: evaluator.url)
        kerigurumi_category.rakutens << rakuten
        review.save_with_product(product_id: rakuten.id, product_type: "Rakuten")
      end
    end

    trait :rakuten_tonnel do
      transient do
        sequence(:name) { |n| "rakuten_tonnel_#{n}"}
        sequence(:url) { |n| "rakuten_tonnel_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        tonnel_category = Category.find(4)
        rakuten = create(:rakuten, name: evaluator.name, url: evaluator.url)
        tonnel_category.rakutens << rakuten
        review.save_with_product(product_id: rakuten.id, product_type: "Rakuten")
      end
    end

    trait :rakuten_other do
      transient do
        sequence(:name) { |n| "rakuten_other_#{n}"}
        sequence(:url) { |n| "rakuten_other_url_#{n}"}
      end
      after(:build) do |review, evaluator|
        other_category = Category.find(5)
        rakuten = create(:rakuten, name: evaluator.name, url: evaluator.url)
        other_category.rakutens << rakuten
        review.save_with_product(product_id: rakuten.id, product_type: "Rakuten")
      end
    end
  end
end