
namespace :update_db do

  desc 'Update Comments with commentable data'
  task comments: :environment do
    Comment.in_batches.each do |comments|
      comments_with_group = comments.group_by{|c| c.post_id }
      comments_with_group.each do |post_id, comments|
        Comment.where(id: comments.mpa(&:id).compact.uniq).update(commentable_id: post_id, commentable_type: 'Post')
      end
    end
  end
end