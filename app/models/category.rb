# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :category_blocks
  has_many :cainzs, through: :category_blocks, source: :blockable, source_type: "Cainz"
  has_many :rakutens, through: :category_blocks, source: :blockable, source_type: "Rakuten"
end
