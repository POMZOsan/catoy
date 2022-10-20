require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'before login' do
    describe 'sign up' do
      context 'send correct form' do
        it 'success to sign up' do
          visit sign_up_path
          fill_in '名前', with: 'name'
          fill_in 'メール', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(current_path).to eq login_path
        end
      end

      context 'send incorrect form' do
        it 'fail to sign up without name' do
          visit sign_up_path
          fill_in '名前', with: ''
          fill_in 'メール', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq users_path
        end

        it 'fail to sign up with over length of name' do
          visit sign_up_path
          fill_in '名前', with: 'a' * 16
          fill_in 'メール', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content '名前は15文字以内で入力してください'
          expect(current_path).to eq users_path
        end

        it 'fail to sign up without email' do
          visit sign_up_path
          fill_in '名前', with: 'name'
          fill_in 'メール', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールを入力してください'
          expect(current_path).to eq users_path
        end

        it 'fail to sign up with duplicated email' do
          existed_user = create(:user, name: 'user_1')
          visit sign_up_path
          fill_in '名前', with: 'name'
          fill_in 'メール', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールはすでに存在します'
          expect(current_path).to eq users_path
        end

        it 'fail to sign up without password' do
          visit sign_up_path
          fill_in '名前', with: 'name'
          fill_in 'メール', with: 'email@example.com'
          fill_in 'パスワード', with: ''
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワードは3文字以上で入力してください'
          expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
          expect(current_path).to eq users_path
        end

        it 'fail to sign up without password_confirmation' do
          visit sign_up_path
          fill_in '名前', with: 'name'
          fill_in 'メール', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: ''
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
          expect(current_path).to eq users_path
        end
      end
    end

    describe 'access to profile' do
      context 'without login' do
        it 'fail to access profile' do
          visit profile_path
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'after login' do
    let(:user) { create :user, name: 'user_1' }
    before { login(user) }

    describe 'edit user' do
      context 'send correct form' do
        it 'success to update user' do
          visit edit_profile_path
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/test_avatar.png"
          fill_in '名前', with: 'namae'
          fill_in 'メール', with: 'email@example.com'
          fill_in '自己紹介', with: 'introduction'
          click_button '更新'
          expect(page).to have_content 'ユーザーを更新しました'
          expect(current_path).to eq profile_path
        end
      end

      context 'send incorrect form' do
        it 'fail to update user without name' do
          visit edit_profile_path
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/test_avatar.png"
          fill_in '名前', with: ''
          fill_in 'メール', with: 'email@example.com'
          fill_in '自己紹介', with: 'introduction'
          click_button '更新'
          expect(page).to have_content 'ユーザーの更新に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq profile_path
        end

        it 'fail to update user without email' do
          visit edit_profile_path
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/test_avatar.png"
          fill_in '名前', with: 'name'
          fill_in 'メール', with: ''
          fill_in '自己紹介', with: 'introduction'
          click_button '更新'
          expect(page).to have_content 'ユーザーの更新に失敗しました'
          expect(page).to have_content 'メールを入力してください'
          expect(current_path).to eq profile_path
        end

        it 'fail to update user with duplicated email' do
          existed_user = create(:user, name: 'existed_user')
          visit edit_profile_path
          attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/test_avatar.png"
          fill_in '名前', with: 'name'
          fill_in 'メール', with: existed_user.email
          fill_in '自己紹介', with: 'introduction'
          click_button '更新'
          expect(page).to have_content 'ユーザーの更新に失敗しました'
          expect(page).to have_content 'メールはすでに存在します'
          expect(current_path).to eq profile_path
        end
      end
    end

    describe 'register my cat' do
      context 'send correct form' do
        it 'success to register my cat' do
          visit profile_path
          click_link '猫ちゃんを登録する'
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: 'my cat'
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 6, 1)
          click_button '登録'
          expect(page).to have_content '猫を作成しました'
          expect(current_path).to eq profile_mycat_path
        end
      end

      context 'send incorrect form' do
        it 'fail to register my cat without name' do
          visit profile_path
          click_link '猫ちゃんを登録する'
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: ''
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 6, 1)
          click_button '登録'
          expect(page).to have_content '猫の作成に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq profile_mycat_path
        end

        it 'fail to register my cat with over length of name' do
          visit profile_path
          click_link '猫ちゃんを登録する'
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: 'a' * 16
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 6, 1)
          click_button '登録'
          expect(page).to have_content '猫の作成に失敗しました'
          expect(page).to have_content '名前は15文字以内で入力してください'
          expect(current_path).to eq profile_mycat_path
        end
      end
    end

    describe 'edit my cat' do
      let!(:cat) { create :cat, name: 'cat', birth_date: DateTime.new(2020, 6, 1), user: user }

      context 'send correct form' do
        it 'success to edit my cat' do
          visit edit_profile_mycat_path
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: 'my cat'
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 8, 1)
          click_button '更新する'
          expect(page).to have_content '猫を更新しました'
          expect(current_path).to eq profile_mycat_path
        end
      end

      context 'send incorrect form' do
        it 'fail to register my cat without name' do
          visit edit_profile_mycat_path
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: ''
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 8, 1)
          click_button '更新する'
          expect(page).to have_content '猫の更新に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq profile_mycat_path
        end

        it 'fail to register my cat with over length of name' do
          my_cat = create(:cat, name: 'cat', birth_date: DateTime.new(2020, 6, 1), user: user)
          visit edit_profile_mycat_path
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: 'a' * 16
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 8, 1)
          click_button '更新する'
          expect(page).to have_content '猫の更新に失敗しました'
          expect(page).to have_content '名前は15文字以内で入力してください'
          expect(current_path).to eq profile_mycat_path
        end
      end
    end

    describe 'watch profile' do
      before do
        visit edit_profile_path
        attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/test_avatar.png"
        fill_in '名前', with: 'test'
        fill_in 'メール', with: 'test@example.com'
        fill_in '自己紹介', with: 'introduction'
        click_button '更新'
        expect(page).to have_content 'ユーザーを更新しました'
        expect(current_path).to eq profile_path
      end

      context 'watch my profile' do
        it 'shows only my profile' do
          click_link '自分のプロフィールを見る'
          expect(current_path).to eq '/users/1'
          expect(page).to have_content 'test'
          expect(page).to have_content 'introduction'
          expect(page).to have_selector 'img#avatar'
        end

        it 'shows me and my cat profile', js: true do
          click_link '猫ちゃんを登録する'
          attach_file 'cat[avatar]', "#{Rails.root}/spec/fixtures/images/test_cat_avatar.png"
          fill_in '名前', with: 'my cat'
          find('#cat_sex_female').choose
          find('#cat_character_gentle').choose
          fill_in '誕生日', with: DateTime.new(2020, 6, 1)
          click_button '登録'
          expect(page).to have_content '猫を作成しました'
          expect(current_path).to eq profile_mycat_path
          visit profile_path
          click_link '自分のプロフィールを見る'
          expect(current_path).to eq '/users/1'
          expect(page).to have_content 'test'
          expect(page).to have_content 'introduction'
          expect(page).to have_selector 'img#avatar'
          expect(page).to have_selector 'img#cat-avatar'
          find('#cat-avatar').hover
          expect(page).to have_content 'my cat'
          expect(page).to have_content 'メス'
          expect(page).to have_content 'おとなしい性格'
          expect(page).to have_content '6月1日生まれ 2才'
        end
      end

      context 'watch others profile' do
        it 'shows others and their cat profile' do
          other_user = create(:user, name: 'other', introduction: 'test')
          others_cat = create(:cat, name: 'others', birth_date: DateTime.new(2017, 5, 1), sex: 1, character: 1, user: other_user)
          visit '/users/2'
          expect(page).to have_content 'other'
          expect(page).to have_content 'test'
          find('#cat-avatar').hover
          expect(page).to have_content 'others'
          expect(page).to have_content 'メス'
          expect(page).to have_content 'おとなしい性格'
          expect(page).to have_content '5月1日生まれ 5才'
        end
      end
    end
  end
end