require 'rails_helper'

RSpec.describe 'Main API', type: :request do
  let!(:sample_post) { create(:post) }
  let(:headers) { { 'Authorization': ENV['API_TOKEN'] } }

  describe 'GET /main' do
    it 'returns posts' do
      get '/main', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /main/:id' do
    context 'when the record exists' do
      it 'returns the post' do
        get "/main/#{sample_post.id}", headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      it 'returns a not found message' do
        get "/main/123456", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /main' do
    context 'with valid parameters' do
      it 'creates a post' do
        post '/main', params: { post: { title: 'New Post', body: 'Post body', author: 'Author' } }, headers: headers
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('New Post')
        expect(json_response['body']).to eq('Post body')
        expect(json_response['author']).to eq('Author')
      end
    end
    
    context 'with invalid parameters' do
      it 'returns status code 422 when request is invalid' do
        post '/main', params: { post: { title: '' } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include("Title can't be blank")
      end
    end
  end

  describe 'PUT /main/:id' do
    context 'when the record exists' do
      it 'updates the post' do
        put "/main/#{sample_post.id}", params: { post: { title: 'Updated Title' } }, headers: headers
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Updated Title')
      end
    end

    context 'when the record does not exist' do
      it 'returns a not found message' do
        put "/main/123456", params: { post: { title: 'Updated Title' } }, headers: headers
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Post Not Found')
      end
    end
  end

  describe 'DELETE /main/:id' do
    context 'when the record exists' do
      it 'deletes the post' do
        delete "/main/#{sample_post.id}", headers: headers
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Post has been deleted')
      end
    end

    context 'when the record does not exist' do
      it 'returns a not found message' do
        delete "/main/123456", headers: headers
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Post Not Found')
      end
    end
  end

  private

  def json
    @json ||= JSON.parse(response.body)
  end
end
