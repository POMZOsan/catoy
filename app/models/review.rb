# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  content    :text             not null
#  rate       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  has_one_attached :image

  belongs_to :user, dependent: :destroy
  has_one :review_block
  has_one :cainz, through: :review_block, source: :product, source_type: 'Cainz'
  has_one :rakuten, through: :review_block, source: :product, source_type: 'Rakuten'

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
