# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  introduction     :text
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  before_save :default_avatar

  has_one_attached :avatar

  has_one :cat, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  private

  def default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sample.jpg')), filename: 'default-avatar.jpg', content_type: 'image/jpg')
    end
  end
end
