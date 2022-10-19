require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let!(:user) { create :user, name: 'user_1'}

    it 'is invalid without title' do
      review = build(:review, title: '')
      review.save_with_product(product_id: 1, product_type: "Cainz")
      expect(review).to be_invalid
      expect(review.errors[:title]).to eq ["を入力してください"] 
    end

    it 'is invalid without content' do
      review = build(:review, content: '')
      review.save_with_product(product_id: 1, product_type: "Cainz")
      expect(review).to be_invalid
      expect(review.errors[:content]).to eq ["を入力してください"] 
    end

    it 'is invalid with over length of title' do
      review = build(:review, title: 'a' * 21)
      review.save_with_product(product_id: 1, product_type: "Cainz")
      expect(review).to be_invalid
      expect(review.errors[:title]).to eq ["は20文字以内で入力してください"] 
    end

    it 'is invalid with over length of content' do
      review = build(:review, content: 'a' * 65536)
      review.save_with_product(product_id: 1, product_type: "Cainz")
      expect(review).to be_invalid
      expect(review.errors[:content]).to eq ["は65535文字以内で入力してください"] 
    end

    it 'is invalid without product_id' do
      review = build(:review)
      review.save_with_product(product_id: nil, product_type: "Cainz")
      expect(review).to be_invalid
      expect(review.errors[:product_id]).to eq ["を選択してください"] 
    end

    it 'is invalid without product_type' do
      review = build(:review)
      review.save_with_product(product_id: 1, product_type: nil)
      expect(review).to be_invalid
      expect(review.errors[:product_type]).to eq ["を選択してください"] 
    end

    it 'is valid with all attributes' do
      review = build(:review, rate: 4)
      review.save_with_product(product_id: 1, product_type: "Cainz")
      expect(review).to be_valid
      expect(review.errors).to be_empty
    end
  end
end