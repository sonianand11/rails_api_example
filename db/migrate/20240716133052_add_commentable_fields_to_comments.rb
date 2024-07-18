class AddCommentableFieldsToComments < ActiveRecord::Migration[7.1]
  def up
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    Comment.in_batches.each do |comments|
      comments_with_group = comments.group_by{|c| c.post_id }
      comments_with_group.each do |post_id, comments|
        Comment.where(comments.mpa(&:id).compact.uniq).update_all(commentable_id: post_id, commentable_type: 'Post')
      end
    end
  end
end
