# == Schema Information
#
# Table name: cainzs
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cainz < ApplicationRecord
  has_one :category, through: :category_block
  has_one :category_block, as: :blockable
end
