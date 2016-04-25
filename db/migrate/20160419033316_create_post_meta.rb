class CreatePostMeta < ActiveRecord::Migration
  def change
    drop_table :post_meta
    
    create_table :post_meta do |t|
      t.belongs_to :post
      t.string :meta_key
      t.string :meta_value

      t.timestamps null: false
    end
  end
end
