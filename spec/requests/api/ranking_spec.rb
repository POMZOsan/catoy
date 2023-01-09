require 'rails_helper'

RSpec.describe 'Ranking', type: :request do
  let!(:user_1) { create :user, name: 'user_1' }
  let!(:user_2) { create :user, name: 'user_2'}
  let!(:active_cat) { create :cat, name: 'cat_1', sex: 0, character: 0, user: user_1 }
  let!(:gentle_cat) { create :cat, name: 'cat_2', sex: 1, character: 1, user: user_2 }
  let!(:review_from_user_1) { create :review, :cainz_nekojarashi, rate: 5, user: user_1 }
  let!(:review_from_user_1) { create :review, :cainz_nezumi, rate: 2, user: user_1 }
  let!(:review_from_user_2) { create :review, :cainz_nekojarashi, rate: 3, user: user_2 }
  let!(:review_from_user_2) { create :review, :cainz_nezumi, rate: 4, user: user_2 }

  context 'GET /api/active_cat_ranking' do
    it 'success get active cat ranking data' do
      get '/api/active_cat_ranking'
      expect(response.status).to eq 200
    end
  end

  fcontext 'GET /api/gentle_cat_ranking' do
    it 'success get gentle cat ranking data' do
      get '/api/gentle_cat_ranking'
      expect(response.status).to eq 200
    end
  end
end