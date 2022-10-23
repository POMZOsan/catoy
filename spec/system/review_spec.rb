require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let(:user) { create :user, name: 'user_1'}
  let(:cainzs) { create_list :cainz, 5 }
  let(:rakutens) { create_list :rakuten, 5 }
  let(:reviews_with_cainz_nekojarashi) { create_list :review, 3, :cainz_nekojarashi, user: user }

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
      end
    end
  end

  describe 'after login' do
    before { login(user) }
    describe 'create new review' do
      context 'send correct form' do
        it 'success create new review', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'test_title'
          fill_in 'content', with: 'test_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            within ("#cainz-#{cainzs[0].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content cainzs[0].name
          click_button '投稿'
          sleep 1
          # api通信の都合上あえてreviews/1にアクセスしている
          visit 'reviews/1'
          expect(page).to have_content 'test_title'
          expect(page).to have_content 'test_content'
          expect(page).to have_content '星3つ'
          expect(page).to have_selector "img[src$='test_review_image.jpeg']"
          expect(page).to have_content cainzs[0].name
        end
      end

      context 'send incorrect form' do
        it 'fail without title', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: ''
          fill_in 'content', with: 'test_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            within ("#cainz-#{cainzs[0].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content cainzs[0].name
          click_button '投稿'
          sleep 1
          expect(page).to have_content 'タイトルを入力してください'
        end

        it 'fail with over length of title', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'a' * 21
          fill_in 'content', with: 'test_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            within ("#cainz-#{cainzs[0].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content cainzs[0].name
          click_button '投稿'
          sleep 1
          expect(page).to have_content 'タイトルは20文字以内で入力してください'
        end

        it 'fail without content', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'test_title'
          fill_in 'content', with: ''
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            within ("#cainz-#{cainzs[0].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content cainzs[0].name
          click_button '投稿'
          sleep 1
          expect(page).to have_content 'レビュー内容を入力してください'
        end

        it 'fail with over length of content', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'tes_title'
          fill_in 'content', with: 'a' * 65536
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            within ("#cainz-#{cainzs[0].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content cainzs[0].name
          click_button '投稿'
          sleep 1
          expect(page).to have_content 'レビュー内容は65535文字以内で入力してください'
        end

        it 'fail without selecting shop and toy', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'test_title'
          fill_in 'content', with: 'test_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          click_button '投稿'
          sleep 0.5
          expect(page).to have_content 'ショップを選択してください'
          expect(page).to have_content 'おもちゃを選択してください'
        end

        it 'fail without selecting toy', js: true do
          cainzs
          visit new_review_path
          fill_in 'title', with: 'test_title'
          fill_in 'content', with: 'test_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[2].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Cainz"]').select_option
          sleep 0.5
          within ('#cainz-modal') do
            find('#close-button').click
          end
          sleep 0.5
          click_button '投稿'
          sleep 0.5
          expect(page).to have_content 'おもちゃを選択してください'
        end
      end
    end

    describe 'edit review' do
      context 'send correct form' do
        it 'success edit review', js: true do
          cainzs
          rakutens
          edit_review = build(:review, rate: 3, user: user)
          edit_review.save_with_product(product_id: cainzs[0].id, product_type: "Cainz")

          visit edit_review_path(edit_review)
          fill_in 'title', with: 'edit_title'
          fill_in 'content', with: 'edit_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[4].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Rakuten"]').select_option
          sleep 0.5
          within ('#rakuten-modal') do
            within ("#rakuten-#{rakutens[1].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content rakutens[1].name
          click_button '編集'
          sleep 1
          # api通信の都合上あえてアクセスしている
          visit review_path(edit_review)
          expect(page).to have_content 'edit_title'
          expect(page).to have_content 'edit_content'
          expect(page).to have_content '星5つ'
          expect(page).to have_selector "img[src$='test_review_image.jpeg']"
          expect(page).to have_content rakutens[1].name
        end
      end

      context 'send incorrect form' do
        it 'fail without title', js: true do
          cainzs
          rakutens
          edit_review = build(:review, rate: 3, user: user)
          edit_review.save_with_product(product_id: cainzs[0].id, product_type: "Cainz")

          visit edit_review_path(edit_review)
          fill_in 'title', with: ''
          fill_in 'content', with: 'edit_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[4].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Rakuten"]').select_option
          sleep 0.5
          within ('#rakuten-modal') do
            within ("#rakuten-#{rakutens[1].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content rakutens[1].name
          click_button '編集'
          sleep 0.5
          expect(page).to have_content 'タイトルを入力してください'
        end

        it 'fail with over length of title', js: true do
          cainzs
          rakutens
          edit_review = build(:review, rate: 3, user: user)
          edit_review.save_with_product(product_id: cainzs[0].id, product_type: "Cainz")

          visit edit_review_path(edit_review)
          fill_in 'title', with: 'a' * 21
          fill_in 'content', with: 'edit_content'
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[4].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Rakuten"]').select_option
          sleep 0.5
          within ('#rakuten-modal') do
            within ("#rakuten-#{rakutens[1].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content rakutens[1].name
          click_button '編集'
          sleep 0.5
          expect(page).to have_content 'タイトルは20文字以内で入力してください'
        end

        it 'fail without content', js: true do
          cainzs
          rakutens
          edit_review = build(:review, rate: 3, user: user)
          edit_review.save_with_product(product_id: cainzs[0].id, product_type: "Cainz")

          visit edit_review_path(edit_review)
          fill_in 'title', with: 'edit_title'
          fill_in 'content', with: ''
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[4].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Rakuten"]').select_option
          sleep 0.5
          within ('#rakuten-modal') do
            within ("#rakuten-#{rakutens[1].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content rakutens[1].name
          click_button '編集'
          sleep 0.5
          expect(page).to have_content 'レビュー内容を入力してください'
        end

        it 'fail with over length of content', js: true do
          cainzs
          rakutens
          edit_review = build(:review, rate: 3, user: user)
          edit_review.save_with_product(product_id: cainzs[0].id, product_type: "Cainz")

          visit edit_review_path(edit_review)
          fill_in 'title', with: 'edit_title'
          fill_in 'content', with: 'a' * 65536
          within all('.vue-star-rating')[1] do
            all('span.vue-star-rating-pointer')[4].click
          end
          attach_file 'image', "#{Rails.root}/spec/fixtures/images/test_review_image.jpeg"
          find('select[name="select-shop"]').find('option[value="Rakuten"]').select_option
          sleep 0.5
          within ('#rakuten-modal') do
            within ("#rakuten-#{rakutens[1].id}") do
              click_button '選択'
            end
          end
          sleep 0.5
          expect(page).to have_content rakutens[1].name
          click_button '編集'
          sleep 0.5
          expect(page).to have_content 'レビュー内容は65535文字以内で入力してください'
        end
      end
    end

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