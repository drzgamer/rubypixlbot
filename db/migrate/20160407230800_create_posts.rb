class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_type
      t.string :author
	  t.string :category
      t.datetime :date
      t.text :title
      t.text :content
      t.text :excerpt
      t.text :status
      t.text :name
      t.datetime :lastedit

      t.timestamps null: false
    end
  end
end
