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
  require 'open-uri'
  include Rails.application.routes.url_helpers

  authenticates_with_sorcery!

  has_one_attached :avatar
  has_one :cat, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favoured_reviews, through: :favourites, source: :review
  has_many :comments, dependent: :destroy
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 200 }

  def mine?(object)
    id == object.user_id
  end

  def favoured?(review)
    favoured_reviews.include?(review)
  end

  def favoured(review)
    favoured_reviews << review
  end

  def remove_favourite(review)
    favoured_reviews.destroy(review)
  end

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end

  def download_and_attach_avatar(profile_image)
    return unless profile_image

    profile_image = profile_image.gsub(/_normal/, '')
    file = URI.open(profile_image)
    avatar.attach(io: file,
                  filename: "twitter_profile_image.#{file.content_type_parse.first.split('/').last}",
                  content_type: file.content_type_parse.first
                  )
  end
end
