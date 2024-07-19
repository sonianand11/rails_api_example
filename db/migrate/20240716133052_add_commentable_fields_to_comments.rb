class AddCommentableFieldsToComments < ActiveRecord::Migration[7.1]
  def change
    # add_column :comments, :commentable_id, :integer
    # add_column :comments, :commentable_type, :string
    change_table :comments, bulk: true do |t|
      t.integer :commentable_id
      t.string  :commentable_type
      t.index :commentable_id
      t.index :commentable_type
    end
  end
end
