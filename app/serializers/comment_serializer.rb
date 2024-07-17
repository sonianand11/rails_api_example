class CommentSerializer < Panko::Serializer

  attributes :id, :body, :user_id
  has_one :user,  serializer: UserSerializer
end