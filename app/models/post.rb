class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many_attached :medias
  validates :title, :description, presence: true
end
