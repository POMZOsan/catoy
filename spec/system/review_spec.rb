require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let(:user) { create :user, name: 'user_1'}
  let(:cainzs) { create_list :cainz, 5 }
  let(:rakutens) { create_list :rakuten, 5 }
  let(:reviews_with_cainz_nekojarashi) { create_list :review, 3, :cainz_nekojarashi, user: user }
  let(:reviews_with_cainz_nezumi) { create_list :review, 3, :cainz_nezumi, user: user }
  let(:reviews_with_rakuten_kerigurumi) { create_list :review, 3, :rakuten_tonnel, user: user }
  let(:reviews_with_rakuten_tonnel) { create_list :review, 3, :rakuten_tonnel, user: user }
  let(:reviews_with_rakuten_other) { create_list :review, 3, :rakuten_other, user: user }

  describe 'before login' do
    describe 'user can look reviews' do
      context 'access to review index' do
        it 'shows reviews' do
          reviews_with_cainz_nekojarashi
          visit reviews_path
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[1].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[2].title
        end

        it 'shows review detail' do
          reviews_with_cainz_nekojarashi
          visit reviews_path
          click_link reviews_with_cainz_nekojarashi[0].title
          expect(current_path).to eq review_path(reviews_with_cainz_nekojarashi[0])
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].content
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].user.name
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].product.name
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].decorate.shop
        end
      end
    end

    describe 'search review' do
      context 'search with category name and product name' do
        it 'shows matched review' do
          reviews_with_cainz_nekojarashi
          visit root_path
          within '#search-form' do
            find('#q_category_name').find('option[value="じゃらし系"]').select_option
            fill_in 'q[keyword]', with: reviews_with_cainz_nekojarashi[0].product.name
          end
          find('#search-button').click
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
        end
      end

      context 'search with category name' do
        it 'shows matched review' do
          reviews_with_cainz_nekojarashi
          visit root_path
          within '#search-form' do
            find('#q_category_name').find('option[value="じゃらし系"]').select_option
          end
          find('#search-button').click
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[1].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[2].title
        end

        context 'search with product name' do
          it 'shows matched review' do
            reviews_with_cainz_nekojarashi
            visit root_path
            within '#search-form' do
              fill_in 'q[keyword]', with: reviews_with_cainz_nekojarashi[0].product.name
            end
            find('#search-button').click
            expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
          end
        end

        context 'search with all categories and no keyword' do
          it 'shows all reviews' do
            reviews_with_cainz_nekojarashi
            reviews_with_cainz_nezumi
            reviews_with_rakuten_kerigurumi
            reviews_with_rakuten_tonnel
            reviews_with_rakuten_other
            visit root_path
            find('#search-button').click
            expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
            expect(page).to have_content reviews_with_cainz_nekojarashi[1].title
            expect(page).to have_content reviews_with_cainz_nekojarashi[2].title
            expect(page).to have_content reviews_with_cainz_nezumi[0].title
            expect(page).to have_content reviews_with_cainz_nezumi[1].title
            expect(page).to have_content reviews_with_cainz_nezumi[2].title
            expect(page).to have_content reviews_with_rakuten_kerigurumi[0].title
            expect(page).to have_content reviews_with_rakuten_kerigurumi[1].title
            expect(page).to have_content reviews_with_rakuten_kerigurumi[2].title
            expect(page).to have_content reviews_with_rakuten_tonnel[0].title
            expect(page).to have_content reviews_with_rakuten_tonnel[1].title
            expect(page).to have_content reviews_with_rakuten_tonnel[2].title
            expect(page).to have_content reviews_with_rakuten_other[0].title
            expect(page).to have_content reviews_with_rakuten_other[1].title
            expect(page).to have_content reviews_with_rakuten_other[2].title
          end
        end
      end
    end
  end

  describe 'after login' do
    before { login(user) }
    describe 'delete review' do
      context 'delete my review' do
        it 'success delete' do
          reviews_with_cainz_nekojarashi
          visit reviews_path
          expect(page).to have_content reviews_with_cainz_nekojarashi[0].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[1].title
          expect(page).to have_content reviews_with_cainz_nekojarashi[2].title
          find("#review-delete-#{reviews_with_cainz_nekojarashi[0].id}").click
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'レビューを削除しました'
          expect(page).not_to have_content reviews_with_cainz_nekojarashi[0].title
        end
      end
    end

    describe 'favourite' do
      let!(:other_user) { create :user, name: 'other_user' }
      let!(:rakuten_kerigurumi) { create_list :review, 2, :rakuten_kerigurumi, user: other_user }
      context 'favourite others review' do
        it 'success add favourite', js: true do
          visit reviews_path
          find("#js-favourite-review-#{rakuten_kerigurumi[1].id}").click
          visit favourites_reviews_path
          expect(page).to have_content rakuten_kerigurumi[1].title
        end
      end
      context 'unfavourite others review' do
        before do
          visit reviews_path
          find("#js-favourite-review-#{rakuten_kerigurumi[1].id}").click
          visit favourites_reviews_path
          expect(page).to have_content rakuten_kerigurumi[1].title
        end
        it 'success remove favourite' do
          visit reviews_path
          find("#js-favourite-review-#{rakuten_kerigurumi[1].id}").click
          visit favourites_reviews_path
          expect(page).not_to have_content rakuten_kerigurumi[1].title
        end
      end
    end

    describe 'comment to review' do
      let!(:other_user) { create :user, name: 'other_user' }
      let!(:rakuten_kerigurumi) { create_list :review, 2, :rakuten_kerigurumi, user: other_user }
      context 'create comment' do
        it 'success create', js: true do
          visit review_path(rakuten_kerigurumi[0])
          within '#comment-form' do
            fill_in 'comment-content', with: 'test_comment'
            click_button '投稿'
          end
          expect(page).to have_content 'test_comment'
        end

        it 'fail create without content', js: true do
          visit review_path(rakuten_kerigurumi[0])
          within '#comment-form' do
            fill_in 'comment-content', with: ''
            click_button '投稿'
          end
          expect(page).to have_content 'コメント内容を入力してください'
        end

        it 'fail create over length of content', js: true do
          visit review_path(rakuten_kerigurumi[0])
          within '#comment-form' do
            fill_in 'comment-content', with: 'a' * 65536
            click_button '投稿'
          end
          expect(page).to have_content 'コメント内容は65535文字以内で入力してください'
        end
      end

      context 'delete comment' do
        it 'success delete', js: true do
          commented = create(:comment, content: 'commented_review', user: user, review: rakuten_kerigurumi[0])
          visit review_path(rakuten_kerigurumi[0])
          within "#comment-#{commented.id}" do
            expect(page).to have_content commented.content
            find("#js-comment-#{commented.id}").click
          end
          expect(page).not_to have_content commented.content
        end
      end
    end
  end
end