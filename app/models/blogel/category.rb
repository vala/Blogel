module Blogel
  class Category < ActiveRecord::Base
    extend FriendlyId
    self.table_name = 'blogel_categories'

    friendly_id :name, use: :slugged

    # Category's posts
    has_and_belongs_to_many :posts, :join_table => "blogel_categories_posts", :foreign_key => 'category_id'

    # Category hierarchy
    belongs_to :parent_category, :class_name => 'Category', :foreign_key => 'parent_id' #, :inverse_of => 'children_categories'
    has_many :children_categories, :class_name => 'Category', :foreign_key => 'parent_id' #, :inverse_of => 'parent_category'

    # Retrieve categories ordered by display index
    scope :ordered, order('display_order_index ASC')

    validates_presence_of :name
  end
end
