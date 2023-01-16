require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let!(:admin) { create :user, :admin, role: 1 }

  describe 'before login' do
    context 'access to /admin' do
      it 'fail to access' do
        visit admin_root_path
        expect(page).to have_content 'ログインしてください'
      end
    end

    context 'access to /admin/login' do
      it 'success to login with correct form' do
        visit admin_login_path
        fill_in 'Email', with: admin.email
        fill_in 'Password', with: 'admin_password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq admin_root_path
      end

      it 'fail to login with incorrect form' do
        visit admin_login_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq admin_login_path
      end

      it 'fail to login if unauthorised user login' do
        unauthorised_user = create(:user, name: 'user_1' )
        visit admin_login_path
        fill_in 'Email', with: unauthorised_user.email
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content '管理画面へのログイン権限がありません'
        expect(current_path).to eq root_path
      end
    end
  end

  describe 'after login' do
    context 'click logout button' do
      it 'success logout' do
        visit admin_login_path
        fill_in 'Email', with: admin.email
        fill_in 'Password', with: 'admin_password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq admin_root_path
        find('#logout').click
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq admin_login_path
      end
    end
  end
end