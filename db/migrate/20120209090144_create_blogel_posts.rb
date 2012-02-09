class CreateBlogelPosts < ActiveRecord::Migration
  def change
    create_table :blogel_posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.boolean :published, :default => true
      t.datetime :published_at
      t.text :additional_fields
      
      t.timestamps
    end
  end
end
