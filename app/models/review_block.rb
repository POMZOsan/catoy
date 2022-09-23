class ReviewBlock < ApplicationRecord
  belongs_to :review
  belongs_to :product, polymorphic: true, dependent: :destroy
end
