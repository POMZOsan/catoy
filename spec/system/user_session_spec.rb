require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create :user, name: 'test'}
  describe 'before login' do
    context 'send correct form' do
      it 'success login' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq root_path 
      end
    end

    context 'send incorrect form' do
      it 'fail login' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'after login' do
    context 'click logout button' do
      it 'success logout' do
        login(user)
        find('#avatar').hover
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end
  end
end