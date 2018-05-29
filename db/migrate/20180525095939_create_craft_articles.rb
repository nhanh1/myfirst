class CreateCraftArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :craft_articles do |t|
    	t.string :title
    	t.text :opening
    	t.string :photo
		  t.text :body
    	t.text :conclusion
    	t.string :about_author
		  t.references :user, foreign_key: true
		
		  t.timestamps
    end

    rename_column :articles, :conclustion, :conclusion
  end
end
