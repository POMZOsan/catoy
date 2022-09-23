class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
