require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:reviewed_user) { create :user, name: 'user_1'}
  let(:comment_user) { create :user, name: 'user_2'}
  let!(:reviews) { create_list :review, 3, :rakuten_kerigurumi, user: reviewed_user}

  before do
    session_params = { email: comment_user.email, password: 'password' }
    post login_path, params: session_params
  end

  context 'GET /api/comments' do
    it 'success get comment data' do
      reviewed_users_comment = create(:comment, user: reviewed_user, review: reviews[0], content: 'comment_1')
      comment_users_comment = create(:comment, user: comment_user, review: reviews[0], content: 'comment_2')

      get "/api/comments", params: { review_id: reviews[0].id }
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(json[1]['content']).to eq reviewed_users_comment.content
      expect(json[0]['content']).to eq comment_users_comment.content
    end
  end

  context 'POST /api/comments' do
    it 'success post valid params' do
      valid_params = { comment: { content: 'test_comment'}, review_id: reviews[0].id }

      post '/api/comments', params: valid_params
      expect(response.status).to eq 200
      expect(Comment.count).to eq 1
    end

    it 'fail post with invalid params' do
      invalid_params = { comment: { content: ''}, review_id: reviews[0].id }

      post '/api/comments', params: invalid_params
      expect(response.status).to eq 400
      expect(Comment.count).to eq 0
    end
  end

  context 'DELETE /api/comments/:id' do
    it 'success delete comment' do
      comments = create_list(:comment, 3, user: comment_user, review: reviews[0])

      delete "/api/comments/#{comments[0].id}"
      expect(response.status).to eq 200
      expect(Comment.count).to eq 2
    end
  end
end