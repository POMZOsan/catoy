# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  sex        :integer          default("male")
#  character  :integer          default("active")
#  birth_date :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cat < ApplicationRecord
  before_save :default_avatar

  belongs_to :user
  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 255 }

  enum sex: { male: 0, female: 1 }
  enum character: { active: 0, gentle: 1 }

  private

  def default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sample.jpg')), filename: 'default-avatar.jpg', content_type: 'image/jpg')
    end
  end
end
