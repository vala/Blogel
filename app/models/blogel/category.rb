module Blogel
  class Category < ActiveRecord::Base
    extend FriendlyId
    self.table_name = 'blogel_categories'

    friendly_id :name, use: :slugged

    has_ancestry cache_depth: true, ancestry_column: :ancestry

    # Category's posts
    has_and_belongs_to_many :posts, :join_table => "blogel_categories_posts", :foreign_key => 'category_id'

    # Retrieve categories ordered by position
    scope :ordered, order('blogel_categories.position ASC')
    scope :tree_roots, where(ancestry: nil).ordered

    validates_presence_of :name

    # Add attributes accessible
    attr_accessible  :posts, :post_ids, :description, :name, :ancestry, :cache_depth, :position
  end
end
