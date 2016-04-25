class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :description
      t.attachment :image

      t.timestamps null: false
    end
  end
end
