class Cainz < ApplicationRecord
  has_one :category, through: :category_block
  has_one :category_block, as: :blockable
end
