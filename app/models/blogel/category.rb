module Blogel
  class Category < ActiveRecord::Base
    include Blogel::ModelInstanceHelperMethods
    
    self.table_name = 'blogel_categories'
    # Category's posts
    has_and_belongs_to_many :posts, :join_table => "blogel_categories_posts", :foreign_key => "category_id"
    # Category hierarchy
    has_many :children, :class_name => 'Category'
    belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'

    # Retrieve categories ordered by display index
    scope :ordered, order('display_order_index ASC')
    
    validates_presence_of :name, :slug
    
    before_validation do
      self.slug = self.name.to_slug
    end
  end
end
