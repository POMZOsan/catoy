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
  end
end