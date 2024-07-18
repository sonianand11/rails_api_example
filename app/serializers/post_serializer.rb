class PostSerializer < Panko::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :medias

  has_many :comments, serializer: CommentSerializer
  has_one :user, serializer: UserSerializer

  def medias
    object.medias.map do |_medias|
      # rails_blob_path(_medias , only_path: true) if object.medias.attached?
      rails_blob_url(_medias)
    end
  end
end