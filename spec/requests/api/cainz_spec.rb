require 'rails_helper'

RSpec.describe 'Cainz', type: :request do
  let(:user) { create :user, name: 'user_1'}
  let!(:cainzs) { create_list :cainz, 5 }

  before do
    session_params = { email: user.email, password: 'password' }
    post login_path, params: session_params
  end

  context 'GET /api/cainz' do
    it 'success get cainz data' do
      get '/api/cainz'
      expect(response.status).to eq 200
    end
  end
end