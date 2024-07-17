class PostSerializer < Panko::Serializer
  attributes :id, :title, :description

  has_many :comments, serializer: CommentSerializer
  has_one :user, serializer: UserSerializer
end