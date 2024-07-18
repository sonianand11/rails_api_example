require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/comments", type: :request do
  let(:user) { create(:user) }
  let(:post_obj) { create(:post, user: user) }
  let(:valid_attributes) { { body: 'Sample Comment' } }
  let(:invalid_attributes) { { body: ''} }
  let!(:comment) { create(:comment, commentable: post_obj, user: user) }
  let(:valid_headers) { {'x-token': JsonWebToken.encode({user_id: user.id}, (Time.now + 24.hours.to_i) )} }
  let(:new_attributes) { { body: 'Sample Comment Update' }  }
  
  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_post_comments_url(post_id: post_obj.id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_post_comment_path(post_id: post_obj.id, id: comment.id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it 'creates a new Comment' do
        expect {
          post api_v1_post_comments_path(post_id: post_obj.id), params: { comment: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do
        post api_v1_post_comments_url(post_id: post_obj.id), params: { comment: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post api_v1_post_comments_url(post_id: post_obj.id),
               params: { comment: invalid_attributes }, as: :json
        }.to change(Comment, :count).by(0)
      end

      it "renders a JSON response with errors for the new comment" do
        post api_v1_post_comments_url(post_id: post_obj.id),
             params: { comment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      it "updates the requested comment" do
        patch api_v1_post_comment_url(post_id: post_obj.id, id: comment.id),
              params: { comment: new_attributes }, headers: valid_headers, as: :json
        comment.reload
        expect(comment.body).to match(new_attributes[:body])
      end

      it "renders a JSON response with the comment" do
        patch api_v1_post_comment_url(post_id: post_obj.id,  id: comment.id),
              params: { comment: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the comment" do
        patch api_v1_post_comment_url(post_id: post_obj.id, id: comment.id),
              params: { comment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      expect {
        delete api_v1_post_comment_url(post_id: post_obj.id,  id: comment.id), headers: valid_headers, as: :json
      }.to change(Comment, :count).by(-1)
    end
  end
end
