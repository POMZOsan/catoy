require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let!(:admin) { create :user, :admin, role: 1 }
  let!(:users) { create_list :user, 4 }
  let!(:reviews_with_cainz_nekojarashi) { create :review, :cainz_nekojarashi, user: users[0] }
  let!(:reviews_with_cainz_nezumi) { create :review, :cainz_nezumi, user: users[1] }
  let!(:reviews_with_rakuten_kerigurumi) { create :review, :rakuten_tonnel, user: users[2] }
  let!(:reviews_with_rakuten_tonnel) { create :review, :rakuten_tonnel, user: users[3]}
  let!(:reviews_with_rakuten_other) { create :review, :rakuten_other, user: admin }

  before { admin_login(admin) }

  describe 'after login' do
    context 'click reviews' do
      it 'shows reivews' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        expect(page).to have_content reviews_with_cainz_nekojarashi.title
        expect(page).to have_content reviews_with_cainz_nezumi.title
        expect(page).to have_content reviews_with_rakuten_kerigurumi.title
        expect(page).to have_content reviews_with_rakuten_tonnel.title
        expect(page).to have_content reviews_with_rakuten_other.title
      end
    end

    context 'click 詳細' do
      it 'shows a review' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        find("#review-show-#{reviews_with_cainz_nekojarashi.id}").click
        expect(current_path).to eq admin_review_path(reviews_with_cainz_nekojarashi.id)
        expect(page).to have_content reviews_with_cainz_nekojarashi.title
      end

      it 'can edit a review' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        find("#review-show-#{reviews_with_cainz_nekojarashi.id}").click
        expect(current_path).to eq admin_review_path(reviews_with_cainz_nekojarashi.id)
        find("#review-edit-#{reviews_with_cainz_nekojarashi.id}").click
        expect(current_path).to eq edit_admin_review_path(reviews_with_cainz_nekojarashi.id)
        fill_in 'タイトル', with: '猫じゃらし'
        click_button '更新する'
        expect(page).to have_content 'レビューを更新しました'
      end

      it 'can delete a review' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        find("#review-show-#{reviews_with_cainz_nekojarashi.id}").click
        expect(current_path).to eq admin_review_path(reviews_with_cainz_nekojarashi.id)
        find("#review-delete-#{reviews_with_cainz_nekojarashi.id}").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'レビューを削除しました'
      end
    end

    context 'click 編集' do
      it 'can edit a review' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        find("#review-edit-#{reviews_with_cainz_nekojarashi.id}").click
        expect(current_path).to eq edit_admin_review_path(reviews_with_cainz_nekojarashi.id)
        fill_in 'タイトル', with: '猫じゃらし'
        fill_in 'レビュー内容', with: '猫じゃらしのレビュー'
        find("#review_rate").set(3)
        attach_file 'review[image]', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
        expect(page).to have_selector '#preview'
        click_button '更新する'
        expect(page).to have_content 'レビューを更新しました'
        expect(current_path).to eq admin_review_path(reviews_with_cainz_nekojarashi.id)
        expect(page).to have_content '猫じゃらし'
      end
    end
  end
end