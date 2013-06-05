class CreateBlogelCategories < ActiveRecord::Migration
  def change
    create_table :blogel_categories do |t|
      t.string :name
      t.string :slug
      t.string :ancestry
      t.text :description
      t.integer :position, :integer

      t.timestamps
    end
    add_index :blogel_categories, :ancestry
    add_index :blogel_categories, :slug, unique: true
  end
end