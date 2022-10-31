# == Schema Information
#
# Table name: rakutens
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Rakuten < ApplicationRecord
  has_one :category_block, as: :blockable, dependent: :destroy
  has_one :category, through: :category_block
  has_many :review_blocks, as: :product, dependent: :destroy
  has_many :reviews, through: :review_blocks

  validates :name, presence: true
  validates :image, presence: true
  validates :url, presence: true
end
