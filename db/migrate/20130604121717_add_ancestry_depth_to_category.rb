class AddAncestryDepthToCategory < ActiveRecord::Migration
  def change
    add_column :blogel_categories, :ancestry_depth, :integer, :default => 0
  end
end
