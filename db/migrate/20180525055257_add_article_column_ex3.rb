class AddArticleColumnEx3 < ActiveRecord::Migration[5.2]
  def change
  	add_column :articles, :opening, :text
  	add_column :articles, :photo, :string
  	rename_column :articles, :description, :body
  	add_column :articles, :conclustion, :text
  	add_column :articles, :about_author, :string

  	change_column :articles, :body, :text
  end
end
