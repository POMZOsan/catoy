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
  end

  # user詳細
  # user編集
  # user削除
  # user検索/名前・権限
end