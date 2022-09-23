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
  has_one :category, through: :category_block
  has_one :category_block, as: :blockable
  has_many :reviews, through: :review_blocks
  has_many :review_blocks, as: :product
end
