module Blogel
  class Post < ActiveRecord::Base
    include Blogel::ModelInstanceHelperMethods
    self.table_name = 'blogel_posts'
    
    # Parent categories, can be several
    has_and_belongs_to_many :categories, :join_table => "blogel_categories_posts", :foreign_key => "post_id"
    has_many :comments
    
    store :additional_fields, :accessors => Blogel.additional_post_fields
    
    # Main image for the post
    has_attached_file :image,
      :styles => {
        :thumb => '200x200#'
      }.merge(Blogel.additional_post_image_styles)
    
    # Get all posts ordered by publish date
    scope :ordered, order('published_at DESC, created_at DESC')
    
    # Ensure the post is slugged
    before_validation do
      self.slug = self.title.to_slug
      self.published_at = Time.now unless self.published_at
    end
    
    # Get all posts from some category, optionally with it's subcategories' posts
    def self.from_category category_id, fetch_from_subcategories = false
      cat = Category.includes(:children).where((category_id.kind_of?(String) ? :slug : :id) => category_id).first
      if cat
        Post.where('category_id IN (?)', cats.children.length > 0 && fetch_from_subcategories ? [cat.id].concat(cats.children.map(&:id)) : [cat.id]).order('published_at DESC, created_at DESC')
      else
        []
      end
    end
    
    def excerpt add_dots = false
      if content.length < 150
        content
      else
        i = 149
        until content[i].match(/^\s$/)
          i -= 1
        end
        "#{content[0, i]}#{add_dots ? ' ...' : ''}"
      end
    end    
  end
end
