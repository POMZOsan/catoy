require 'rails_helper'

RSpec.describe Favourite, type: :model do
  describe 'validation' do
    let!(:user_1) { create :user, name: 'user_1'}
    let!(:user_2) { create :user, name: 'user_2'}

    it 'is invalid with user favourites the same review' do
      review = build(:review, user: user_1)
      review.save_with_product(product_id: 1, product_type: "Cainz")
      favourite_1 = create(:favourite, user: user_2, review: review)
      favourite_2 = build(:favourite, user: user_2, review: review)
      expect(favourite_2).to be_invalid
      expect(favourite_2.errors[:user_id]).to eq ["はすでに存在します"] 
    end

    it 'is valid with user favourites the other reivew' do
      review_1 = build(:review, title: "review_1", user: user_1)
      review_2 = build(:review, title: "review_2", user: user_1)
      review_1.save_with_product(product_id: 1, product_type: "Cainz")
      review_2.save_with_product(product_id: 2, product_type: "Cainz")
      favourite_1 = create(:favourite, user: user_2, review: review_1)
      favourite_2 = build(:favourite, user: user_2, review: review_2)
      expect(favourite_2).to be_valid
      expect(favourite_2.errors).to be_empty
    end
  end
end