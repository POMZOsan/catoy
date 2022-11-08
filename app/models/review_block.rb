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

  def self.toys_ranking(character:)
    scoped_ids = joins(review: {user: :cat}).
                 where(cat: {character: character}).
                 group(:product_type, :product_id, 'reviews.rate').
                 order('count(product_id) desc').
                 limit(5).
                 pluck(:id)
    joins(:review).where(id: scoped_ids).order('reviews.rate desc')
  end
end
