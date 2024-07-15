# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Sample Title', description: 'Sample Description', user: user } }

  context 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(valid_attributes)
      expect(post).to be_valid
    end

    it 'is invalid without a user' do
      post = Post.new(valid_attributes.except(:user))
      expect(post).not_to be_valid
      expect(post.errors[:user]).to include('must exist')
    end

    it 'is invalid without a title' do
      post = Post.new(valid_attributes.except(:title))
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      post = Post.new(valid_attributes.except(:description))
      expect(post).not_to be_valid
      expect(post.errors[:description]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      assoc = Post.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
