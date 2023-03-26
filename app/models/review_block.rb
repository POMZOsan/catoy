# == Schema Information
#
# Table name: review_blocks
#
#  id           :integer          not null, primary key
#  review_id    :integer          not null
#  product_type :string           not null
#  product_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ReviewBlock < ApplicationRecord
  belongs_to :review
  belongs_to :product, polymorphic: true

  validates :product_type, presence: true
  validates :product_id, presence: true

  scope :reviews_count, ->(cat_character) { joins(review: {user: :cat}).where(cat: {character: cat_character}).group(:product_type, :product_id).count }
  scope :avg_reviews_rate, ->(cat_character) { joins(review: {user: :cat}).where(cat: {character: cat_character}).group(:product_type, :product_id).average('reviews.rate') }

  def self.toys_ranking(character:)
    review_counts = reviews_count(character)
    review_counts_values = review_counts.values
    review_counts_keys = review_counts.keys
    reviews_avg_rates = avg_reviews_rate(character).values.map {|v| v = v.to_f.round(1) }

    create_toy_data(review_counts_keys, review_counts_values, reviews_avg_rates)

  end
end

def create_toy_data(toys, review_counts, review_rates)
  arr = []

  toys.size.times do |i|
    shop = toys[i][0]
    toy_id = toys[i][1]
    count = review_counts[i]
    rate = review_rates[i]
    if shop == "Cainz"
      cainz_toy = Cainz.find(toy_id)
      hash = { shop: "カインズホーム",
               toy_id: toy_id,
               name: "#{cainz_toy.name}",
               image: "#{cainz_toy.image}",
               url: "#{cainz_toy.url}",
               count: count,
               rate: rate
              }
    else
      rakuten_toy = Rakuten.find(toy_id)
      hash = { shop: "楽天24",
               toy_id: toy_id,
               name: "#{rakuten_toy.name}",
               image: "#{rakuten_toy.image}",
               url: "#{rakuten_toy.url}",
               count: count,
               rate: rate
              }
    end
    arr << hash
  end
  sorted_arr = arr.sort_by{ |a| [-a[:count], -a[:rate]] }
  return sorted_arr
end
