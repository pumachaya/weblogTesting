require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  let!(:post_instance) { create(:post) }
  let!(:comment_instance) { create(:comment, post: post_instance) }
  let(:headers) { { 'Authorization': ENV['API_TOKEN'] } }

  describe 'GET /main/:main_id/comments' do
    it 'returns all comments for a post' do
      get "/main/#{post_instance.id}/comments", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(1) # Adjust based on actual setup
    end

    it 'returns a not found message when post does not exist' do
      get "/main/123456/comments", headers: headers
      expect(response).to have_http_status(:not_found)
      expect(json['error']).to eq('Post Not Found')
    end
  end

  describe 'GET /main/:main_id/comments/:id' do
    context 'when the comment exists' do
      it 'returns the comment' do
        get "/main/#{post_instance.id}/comments/#{comment_instance.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json['commenter']).to eq(comment_instance.commenter)
      end
    end

    context 'when the comment does not exist' do
      it 'returns a not found message' do
        get "/main/#{post_instance.id}/comments/123456", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('Post or Comment Not Found')
      end
    end
  end

  describe 'POST /main/:main_id/comments' do
    context 'with valid parameters' do
      it 'creates a new comment' do
        post "/main/#{post_instance.id}/comments", params: { comment: { commenter: 'New Commenter', body: 'New Comment Body' } }, headers: headers
        expect(response).to have_http_status(:created)
        expect(json['commenter']).to eq('New Commenter')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error message' do
        post "/main/#{post_instance.id}/comments", params: { comment: { commenter: '', body: '' } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to include("Commenter can't be blank", "Body can't be blank")
      end
    end
  end

  describe 'PUT /main/:main_id/comments/:id' do
    context 'when the comment exists' do
      it 'updates the comment' do
        put "/main/#{post_instance.id}/comments/#{comment_instance.id}", params: { comment: { body: 'Updated Comment Body' } }, headers: headers
        expect(response).to have_http_status(:ok)
        expect(json['body']).to eq('Updated Comment Body')
      end
    end

    context 'when the comment does not exist' do
      it 'returns a not found message' do
        put "/main/#{post_instance.id}/comments/123456", params: { comment: { body: 'Updated Body' } }, headers: headers
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('Post or Comment Not Found')
      end
    end
  end

  describe 'DELETE /main/:main_id/comments/:id' do
    context 'when the comment exists' do
      it 'deletes the comment' do
        delete "/main/#{post_instance.id}/comments/#{comment_instance.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json['message']).to eq('Comment has been deleted')
      end
    end

    context 'when the comment does not exist' do
      it 'returns a not found message' do
        delete "/main/#{post_instance.id}/comments/123456", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('Post or Comment Not Found')
      end
    end
  end

  private

  def json
    @json ||= JSON.parse(response.body)
  end
end
