class CategoryBlock < ApplicationRecord
  belongs_to :category
  belongs_to :blockable
end
