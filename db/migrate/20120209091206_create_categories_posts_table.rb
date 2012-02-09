class CreateCategoriesPostsTable < ActiveRecord::Migration
  def up
    create_table :blogel_categories_posts, :id => false do |t|
      t.integer :category_id
      t.integer :post_id
    end
  end

  def down
    drop_table :blogel_categories_posts
  end
end
