require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is invalid without name' do
      user = build(:user, name: '')
      expect(user).to be_invalid
      expect(user.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid with over length of name' do
      user = build(:user, name: 'a' * 16)
      expect(user).to be_invalid
      expect(user.errors[:name]).to eq ["は15文字以内で入力してください"]
    end

    it 'is invalid without email' do
      user = build(:user, email: '')
      expect(user).to be_invalid
      expect(user.errors[:email]).to eq ["を入力してください"]
    end

    it 'is invalid with existed email' do
      user_1 = create(:user, name: 'user_1', email: 'user_1@example.com')
      user_2 = build(:user, name: 'user_2', email: 'user_1@example.com')
      expect(user_2).to be_invalid
      expect(user_2.errors[:email]).to eq ["はすでに存在します"]
    end

    it 'is invalid without password' do
      user = build(:user, password: '')
      expect(user).to be_invalid
      expect(user.errors[:password]).to eq ["は3文字以上で入力してください"]
    end

    it 'is invalid with different_password_confirmation' do
      user = build(:user, password: 'password_1', password_confirmation: 'password')
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
    end

    it 'is invalid without password_confirmation' do
      user = build(:user, name: 'user_1', password_confirmation: '')
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません", "を入力してください"]
    end

    it 'is invalid with over length of introduction' do
      user = build(:user, name: 'user_1', introduction: 'a' * 201)
      expect(user).to be_invalid
      expect(user.errors[:introduction]).to eq ["は200文字以内で入力してください"]
    end

    it 'is valid with all attributes' do
      user = build(:user, name: 'user_1', introduction: 'a' * 200)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end

