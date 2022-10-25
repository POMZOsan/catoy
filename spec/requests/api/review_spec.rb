require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create :user, name: 'user_1'}
  let(:review) { create :review, :cainz_nekojarashi, user: user }

  before do
    session_params = { email: user.email, password: 'password' }
    post login_path, params: session_params
  end

  context 'GET /api/reviews/:id/edit' do
    it 'success get review data' do
      review
      review.image.attach(Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'))

      get "/api/reviews/#{review.id}/edit"
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(json['id']).to eq review.id
      expect(json['title']).to eq review.title
      expect(json['content']).to eq review.content
      expect(json['rate']).to eq review.rate
      expect(json['image_url']).to eq review.url_for(review.image)
      expect(json['product_id']).to eq review.product_id
      expect(json['product_type']).to eq review.product_type
      expect(json['product']['name']).to eq review.product.name
    end
  end

  context 'POST /api/reviews' do
    it 'success post review data' do
      valid_params = 
      { title: 'test_title',
        content: 'test_content',
        rate: 3,
        image: Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'),
        product_id: 1,
        product_type: 'Cainz'
      }
      post api_reviews_path, params: valid_params
      expect(response.status).to eq 200
      expect(Review.count).to eq 1
    end

    it 'fail post with invalid params' do
      invalid_params = 
      { title: '',
        content: '',
        rate: 3,
        image: Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'),
        product_id: nil,
        product_type: nil
      }
      post api_reviews_path, params: invalid_params
      expect(response.status).to eq 400
    end
  end

  context 'PUT /api/reivews/:id' do
    it 'success put review data' do
      review
      review.image.attach(Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'))

      valid_params = 
      { title: 'edit_title',
        content: 'edit_content',
        rate: 3,
        image: Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'),
        product_id: 1,
        product_type: 'Cainz'
      }
      put "/api/reviews/#{review.id}", params: valid_params
      expect(response.status).to eq 200
      expect(Review.count).to eq 1
    end

    it 'fail put with invalid params' do
      review
      review.image.attach(Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'))

      invalid_params = 
      { title: '',
        content: '',
        rate: 3,
        image: Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png'),
        product_id: nil,
        product_type: nil
      }
      put "/api/reviews/#{review.id}", params: invalid_params
      expect(response.status).to eq 400
    end
  end
end