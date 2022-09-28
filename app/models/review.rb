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

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  def save_with_product(product_type)
    return false if product_type == 'no_product'

    ActiveRecord::Base.transaction do
      self.toy(product_type)
      save!
    end
    true

  rescue StandardError
    false
  end

  def toy(product_type)
    if product_type.class.name == 'Cainz'
      self.cainz = product_type
    elsif product_type.class.name == 'Rakuten'
      self.rakuten = product_type
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
