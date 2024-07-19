# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(body: 'This is a comment', user: user, commentable: post)
      expect(comment).to be_valid
    end

    it 'is not valid without a body' do
      comment = Comment.new(body: nil, user: user, commentable: post)
      expect(comment).not_to be_valid
    end

    it 'is not valid without a user' do
      comment = Comment.new(body: 'This is a comment', user: nil, commentable: post)
      expect(comment).not_to be_valid
    end

    it 'is not valid without a post' do
      comment = Comment.new(body: 'This is a comment', user: user, commentable: nil)
      expect(comment).not_to be_valid
    end
  end
end
