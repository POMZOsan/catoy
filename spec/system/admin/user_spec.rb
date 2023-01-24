require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:admin) { create :user, :admin, role: 1 }
  before do
    admin_login(admin)
    3.times do |i|
      create(:user, name: "user_#{i}")
    end
  end

  describe 'after login' do
    context 'click users' do
      it 'shows users' do
        click_link 'Users'
        expect(current_path).to eq admin_users_path
        users = User.all
        expect(page).to have_content users[0].name
        expect(page).to have_content users[1].name
        expect(page).to have_content users[2].name
        expect(page).to have_content users[3].name
      end
    end

    context 'click 詳細' do
      let(:new_user) { create :user, name: 'new_user' }
      it 'shows a user' do
        new_user
        click_link 'Users'
        expect(current_path).to eq admin_users_path
        find("#user-show-#{new_user.id}").click
        expect(current_path).to eq admin_user_path(new_user.id)
        expect(page).to have_content new_user.name
      end

      it 'can edit a user' do
        new_user
        click_link 'Users'
        expect(current_path).to eq admin_users_path
        find("#user-show-#{new_user.id}").click
        expect(current_path).to eq admin_user_path(new_user.id)
        expect(page).to have_content new_user.name
        find("#user-edit-#{new_user.id}").click
        expect(current_path).to eq edit_admin_user_path(new_user.id)
        fill_in '名前', with: 'edited_user'
        click_button '更新する'
        expect(current_path).to eq admin_user_path(new_user.id)
        expect(page).to have_content 'edited_user'
      end

      it 'can delete a user' do
        new_user
        click_link 'Users'
        expect(current_path).to eq admin_users_path
        find("#user-show-#{new_user.id}").click
        expect(current_path).to eq admin_user_path(new_user.id)
        expect(page).to have_content new_user.name
        find("#user-delete-#{new_user.id}").click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq admin_users_path
        expect(page).to have_content 'ユーザーを削除しました'
        expect(page).to_not have_content new_user.name
      end
    end
  end

  # user編集
  # user削除
  # user検索/名前・権限
end