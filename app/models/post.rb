class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many_attached :medias
  validates_presence_of :title, :description
  # validates :medias, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'video/mp4', 'videp/mpeg', 'audio/mp3'], size: { less_than: 5.megabytes }

end
