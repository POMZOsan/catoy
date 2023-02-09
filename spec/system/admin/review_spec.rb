require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let!(:admin) { create :user, :admin, role: 1 }
  let!(:users) { create_list :user, 4 }
  let!(:reviews_with_cainz_nekojarashi) { create :review, :cainz_nekojarashi, user: users[0], rate: 3 }
  let!(:reviews_with_cainz_nezumi) { create :review, :cainz_nezumi, user: users[1], rate: 5 }
  let!(:reviews_with_rakuten_kerigurumi) { create :review, :rakuten_kerigurumi, user: users[2], rate: 3 }
  let!(:reviews_with_rakuten_tonnel) { create :review, :rakuten_tonnel, user: users[3], rate: 1}
  let!(:reviews_with_rakuten_other) { create :review, :rakuten_other, user: admin, rate: 4 }

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

    context 'click 削除' do
      it 'can delete a review' do
        click_link 'Reviews'
        expect(current_path).to eq admin_reviews_path
        reviews_before_delete = Review.count
        find("#review-delete-#{reviews_with_cainz_nekojarashi.id}").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'レビューを削除しました'
        reviews_after_delete = Review.count
        expect(reviews_after_delete).not_to eq reviews_before_delete
      end
    end

    context 'search specified reviews' do
      before do
        click_link 'Review'
        expect(current_path).to eq admin_reviews_path
      end

      it 'can get reviews by title or content' do
        fill_in 'タイトル/レビュー内容', with: reviews_with_cainz_nekojarashi.title
        find('#search-button').click
        expect(page).to have_content reviews_with_cainz_nekojarashi.title
        fill_in 'タイトル/レビュー内容', with: reviews_with_rakuten_tonnel.content
        find('#search-button').click
        expect(page).to have_content reviews_with_rakuten_tonnel.title
      end

      it 'can get reviews by rate' do
        reviews_with_rate_3 = Review.where(rate: 3)
        find('#q_rate').set(3)
        find('#search-button').click
        reviews_with_rate_3.count.times do |i|
          expect(page).to have_content reviews_with_rate_3[i].title
        end
      end

      it 'can get reviews by the range of created time or updated time' do
        january_review_1 = create(:review, :rakuten_other, user: admin, rate: 3, created_at: Date.new(2023, 1, 1))
        january_review_2 = create(:review, :cainz_nezumi, user: users[0], rate: 4, created_at: Date.new(2023, 1, 31))
        fill_in 'q[created_at_gteq]', with: january_review_1.created_at
        fill_in 'q[created_at_lteq]', with: january_review_2.created_at
        find('#search-button').click
        expect(page).to have_content january_review_1.title
        expect(page).to have_content january_review_2.title
      end

      it 'can get reviews by toy shops' do
        cainz_reviews = Review.shop_contain('カインズ')
        select 'カインズ', from: 'q[shop]'
        find('#search-button').click
        cainz_reviews.count.times do
          expect(page).to have_content cainz_reviews.title
        end
        rakuten_reviews = Review.shop_contain('楽天')
        select '楽天', from: 'q[shop]'
        find('#search-button').click
        rakuten_reviews.count.times do
          expect(page).to have_content rakuten_reviews.title
        end
      end

      it 'can get reviews by many keywords' do
        review = create(:review, :cainz_nezumi, user: users[2], rate: 4, created_at: Date.new(2023, 2, 1))
        fill_in 'タイトル/レビュー内容', with: review.title
        find('#q_rate').set(review.rate)
        select 'カインズ', from: 'q[shop]'
        find('#search-button').click
        expect(page).to have_content review.title
      end
    end
  end
end