require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let!(:user) { create :user, name: 'user_1'}
    it 'is invalid without content' do
      review = build(:review, user: user)
      review.save_with_product(product_id: 1, product_type: 'Cainz')
      comment = build(:comment, user: user, review: review, content: '')
      expect(comment).to be_invalid
      expect(comment.errors[:content]).to eq ["を入力してください"]
    end

    it 'is invalid with over length of content' do
      review = build(:review, user: user)
      review.save_with_product(product_id: 1, product_type: 'Cainz')
      comment = build(:comment, user: user, review: review, content: 'a' * 65536)
      expect(comment).to be_invalid
      expect(comment.errors[:content]).to eq ["は65535文字以内で入力してください"]
    end

    it 'is valid with correct content' do
      review = build(:review, user: user)
      review.save_with_product(product_id: 1, product_type: 'Cainz')
      comment = build(:comment, user: user, review: review, content: 'test')
      expect(comment).to be_valid
      expect(comment.errors).to be_empty
    end
  end
end