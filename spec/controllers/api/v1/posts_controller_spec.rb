# spec/controllers/api/v1/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Sample Title', description: 'Sample Description' } }
  let(:invalid_attributes) { { title: '', description: '' } }
  let!(:post_obj) { create(:post, user: user) }
  let(:token) { JsonWebToken.encode({user_id: user.id}, (Time.now + 24.hours.to_i) ) }
  let(:valid_headers) { {'x-token': token} }

  before do
    request.headers.merge!(valid_headers)
    allow(JsonWebToken).to receive(:decode).and_return({ 'user_id' => user.id })
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns all posts' do
      get :index
      expect(JSON.parse(response.body).size).to eq(Post.count)
    end
  end

  describe 'GET #show' do
    context 'when the post exists' do
      it 'returns a success response' do
        get :show, params: { id: post_obj.to_param }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the post' do
        get :show, params: { id: post_obj.to_param }
        expect(JSON.parse(response.body)['id']).to eq(post_obj.id)
      end
    end

    context 'when the post does not exist' do
      it 'returns a not found response' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'returns a created response' do
        post :create, params: { post: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: invalid_attributes }
        }.to change(Post, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Title' } }

      it 'updates the requested post' do
        put :update, params: { id: post_obj.id, post: new_attributes }
        post_obj.reload
        expect(post_obj.title).to eq('Updated Title')
      end

      it 'returns a success response' do
        put :update, params: { id: post_obj.to_param, post: new_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        put :update, params: { id: post_obj.to_param, post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      expect {
        delete :destroy, params: { id: post_obj.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'returns a no content response' do
      delete :destroy, params: { id: post_obj.to_param }
      expect(response).to have_http_status(:ok)
    end
  end
end
