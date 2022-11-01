require 'rails_helper'

RSpec.describe 'Rakuten', type: :request do
  let(:user) { create :user, name: 'user_1'}
  let!(:rakutens) { create_list :rakuten, 5 }

  before do
    session_params = { email: user.email, password: 'password' }
    post login_path, params: session_params
  end

  context 'GET /api/rakuten' do
    it 'success get rakuten data' do
      get '/api/rakuten'
      expect(response.status).to eq 200
    end
  end
end