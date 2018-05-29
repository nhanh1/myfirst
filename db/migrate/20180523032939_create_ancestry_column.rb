class CreateAncestryColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :ancestry, :string
  	add_column :comments, :commentable_id, :integer
  	add_column :comments, :commentable_type, :string
    add_index :comments, :ancestry

    remove_column :comments, :article_id
  end
end
