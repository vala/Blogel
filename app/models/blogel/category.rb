module Blogel
  class Category < ActiveRecord::Base
    # Category's posts
    has_and_belongs_to_many :posts, :join_table => "blogel_categories_posts", :foreign_key => "post_id"
    # Category hierarchy
    has_many :children, :class_name => 'Category'
    belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'

    # Retrieve categories ordered by display index
    scope :ordered, order('display_order_index ASC')
  end
end
