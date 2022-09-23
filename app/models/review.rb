class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :review_block
  has_one :cainz, through: :review_block, source: :product, source_type: 'Cainz'
  has_one :rakuten, through: :review_block, source: :product, source_type: 'Rakuten'

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
