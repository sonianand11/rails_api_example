# spec/controllers/api/v1/authentication_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe 'POST #login' do
    let(:user) { create(:user, password: 'password123') }

    context 'with valid credentials' do
      before do
        post :login, params: { email: user.email, password: 'password123' }
      end

      it 'returns http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a token' do
        expect(json['token']).to be_present
      end

      it 'returns an expiration time' do
        expect(json['exp']).to be_present
      end

      it 'returns the username' do
        expect(json['username']).to eq(user.username)
      end

      it 'returns the name' do
        expect(json['name']).to eq(user.name)
      end
    end

    context 'with invalid credentials' do
      before do
        post :login, params: { email: user.email, password: 'wrongpassword' }
      end

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json['error']).to eq('unauthorized')
      end
    end

    context 'without email' do
      before do
        post :login, params: { password: 'password123' }
      end

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json['error']).to eq('unauthorized')
      end
    end

    context 'without password' do
      before do
        post :login, params: { email: user.email }
      end

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json['error']).to eq('unauthorized')
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
