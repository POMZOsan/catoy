require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe 'validation' do
    let!(:user) { create :user, name: 'user_1'}

    it 'is invalid without name' do
      cat = build(:cat)
      expect(cat).to be_invalid
      expect(cat.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid over length of name' do
      cat = build(:cat, name: 'a' * 16)
      expect(cat).to be_invalid
      expect(cat.errors[:name]).to eq ["は15文字以内で入力してください"]
    end

    it 'is valid with all attributes' do
      cat = build(:cat, name: 'cat_1', sex: 1, character: 1, birth_date: DateTime.new(2020, 6, 1))
      expect(cat).to be_valid
      expect(cat.errors).to be_empty
    end
  end
end