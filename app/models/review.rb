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
  include Rails.application.routes.url_helpers

  has_one_attached :image

  belongs_to :user
  has_one :review_block, dependent: :destroy
  has_one :cainz, through: :review_block, source: :product, source_type: 'Cainz'
  has_one :rakuten, through: :review_block, source: :product, source_type: 'Rakuten'
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65535 }
  validate :need_product_id
  validate :need_product_type

  def self.category_reviews_ids(category)
    cainz = joins(cainz: :category).where(category: {name: category}).ids
    rakuten = joins(rakuten: :category).where(category: {name: category}).ids
    cainz.concat(rakuten)
  end

  def self.product_reviews_ids(product_name)
    cainz = joins(:cainz).where('name LIKE ?', "%#{product_name}%").ids
    rakuten = joins(:rakuten).where('name LIKE ?', "%#{product_name}%").ids
    cainz.concat(rakuten)
  end

  def save_with_product(product_id:, product_type:)
    ActiveRecord::Base.transaction do
      review_block = self.build_review_block(product_id: product_id, product_type: product_type)
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
    if review_block.present?
      if review_block.product_type == 'Cainz'
        cainz
      elsif review_block.product_type == 'Rakuten'
        rakuten
      end
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

  def image_url
    image.attached? ? url_for(image) : nil
  end

  private

  def need_product_type
    if review_block.product_type.blank?
      errors.add(:product_type, 'を選択してください')
    end
  end

  def need_product_id
    if review_block.product_id.blank?
      errors.add(:product_id, 'を選択してください')
    end
  end
end
