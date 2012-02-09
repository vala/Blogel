class CreateBlogelCategories < ActiveRecord::Migration
  def change
    create_table :blogel_categories do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id
      t.text :description
      t.integer :display_order_index
      
      t.timestamps
    end
  end
end
