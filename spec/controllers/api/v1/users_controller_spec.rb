# spec/controllers/api/v1/users_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:valid_attributes) { { name: 'New User', username: 'newuser', email: 'newuser@example.com', password: 'password123' } }
  let(:invalid_attributes) { { name: '', username: '', email: 'invalidemail', password: 'short' } }

  before do
    allow(controller).to receive(:authorize_request).and_return(true)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns all users' do
      get :index
      expect(JSON.parse(response.body).size).to eq(User.count)
    end
  end

  describe 'GET #show' do
    context 'when the user exists' do
      it 'returns a success response' do
        get :show, params: { id: user.to_param }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user' do
        get :show, params: { id: user.to_param }
        expect(JSON.parse(response.body)['id']).to eq(user.id)
      end
    end

    context 'when the user does not exist' do
      it 'returns a not found response' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        get :show, params: { id: 0 }
        expect(JSON.parse(response.body)['errors']).to eq('User not found')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a created response' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect {
          post :create, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        post :create, params: invalid_attributes
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated User' } }

      it 'updates the requested user' do
        put :update, params: { id: user.to_param }.merge(new_attributes)
        user.reload
        expect(user.name).to eq('Updated User')
      end

      it 'returns a success response' do
        put :update, params: { id: user.to_param }.merge(new_attributes)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        put :update, params: { id: user.to_param }.merge(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        put :update, params: { id: user.to_param }.merge(invalid_attributes)
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end

    context 'when the user does not exist' do
      it 'returns a not found response' do
        put :update, params: { id: 0 }.merge(valid_attributes)
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        put :update, params: { id: 0 }.merge(valid_attributes)
        expect(JSON.parse(response.body)['errors']).to eq('User not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'returns a no content response' do
      delete :destroy, params: { id: user.to_param }
      expect(response).to have_http_status(:no_content)
    end

    context 'when the user does not exist' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        delete :destroy, params: { id: 0 }
        expect(JSON.parse(response.body)['errors']).to eq('User not found')
      end
    end
  end
end
