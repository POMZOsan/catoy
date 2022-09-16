class Category < ApplicationRecord
  has_many :category_blocks
  has_many :cainzs, through: :category_blocks, source: :blockable, source_type: "Cainz"
  has_many :rakutens, through: :category_blocks, source: :blockable, source_type: "Rakuten"
end
