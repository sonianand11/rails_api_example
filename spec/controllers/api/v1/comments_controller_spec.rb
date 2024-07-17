# spec/controllers/api/v1/comments_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_obj) { create(:post, user: user) }
  let(:valid_attributes) { { body: 'Sample Comment' } }
  let(:invalid_attributes) { { body: '' } }
  let!(:comment) { create(:comment, commentable: post_obj, user: user) }
  let(:token) { JsonWebToken.encode({user_id: user.id}, (Time.now + 24.hours.to_i) ) }
  let(:valid_headers) { {'x-token': token} }

  before do
    request.headers.merge!(valid_headers)
    allow(JsonWebToken).to receive(:decode).and_return({ 'user_id' => user.id })
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { post_id: post_obj.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns all comments for the post' do
      get :index, params: { post_id: post_obj.id }
      expect(JSON.parse(response.body).size).to eq(post_obj.comments.count)
    end
  end

  describe 'GET #show' do
    context 'when the comment exists' do
      it 'returns a success response' do
        get :show, params: { post_id: post_obj.id, id: comment.to_param }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the comment' do
        get :show, params: { post_id: post_obj.id, id: comment.to_param }
        expect(JSON.parse(response.body)['id']).to eq(comment.id)
      end
    end

    context 'when the comment does not exist' do
      it 'returns a not found response' do
        get :show, params: { post_id: post_obj.id, id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new comment' do
        expect {
          post :create, params: { post_id: post_obj.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new comment' do
        expect {
          post :create, params: { post_id: post_obj.id, comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { post_id: post_obj.id, comment: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { body: 'Updated Comment' } }

      it 'updates the requested comment' do
        put :update, params: { post_id: post_obj.id, id: comment.id, comment: new_attributes }
        comment.reload
        expect(comment.body).to eq('Updated Comment')
      end

      it 'returns a success response' do
        put :update, params: { post_id: post_obj.id, id: comment.id, comment: new_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        put :update, params: { post_id: post_obj.id, id: comment.id, comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      expect {
        delete :destroy, params: { post_id: post_obj.id, id: comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, params: { post_id: post_obj.id, id: comment.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
