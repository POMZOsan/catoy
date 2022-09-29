# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  content    :text             not null
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_one :review_block, dependent: :destroy
  has_one :cainz, through: :review_block, source: :product, source_type: 'Cainz'
  has_one :rakuten, through: :review_block, source: :product, source_type: 'Rakuten'
  has_many :favourites, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  def save_with_product(product_id:, product_type:)

    ActiveRecord::Base.transaction do
      review_block = self.build_review_block(product_id: product_id, product_type: product_type)
      return false if review_block.invalid? # Add: review_blockがvalidationに引っかかった時のエラーメッセージ表示
      save!
    end
    true

  rescue StandardError
    false
  end

  def product_type
    if review_block.present?
      review_block.product_type
    end
  end

  def product_id
    if review_block.present?
      review_block.product_id
    end
  end

  def product
    if review_block.product_type == 'Cainz'
      cainz
    elsif review_block.product_type == 'Rakuten'
      rakuten
    end
  end

  def rating_parcent
    if rate.present?
      cal = rate.to_f / 5 * 100
      parcent = cal.round
      return parcent
    else
      return 0
    end
  end
end
