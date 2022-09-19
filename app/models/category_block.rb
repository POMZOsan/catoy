# == Schema Information
#
# Table name: category_blocks
#
#  id             :integer          not null, primary key
#  category_id    :integer          not null
#  blockable_type :string           not null
#  blockable_id   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class CategoryBlock < ApplicationRecord
  belongs_to :category
  belongs_to :blockable, polymorphic: true, dependent: :destroy
end
