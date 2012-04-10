require 'scoped_search'

module Blogel
  class Post < ActiveRecord::Base
    include Blogel::ModelInstanceHelperMethods
    include ActionView::Helpers::TagHelper
    self.table_name = 'blogel_posts'
    
    paginates_per Blogel.posts_per_page
    
    # Parent categories, can be several
    has_and_belongs_to_many :categories, :join_table => "blogel_categories_posts", :foreign_key => "post_id"
    has_and_belongs_to_many :tags, :join_table => "blogel_posts_tags", :foreign_key => 'post_id'
    has_many :comments
    
    store :additional_fields, :accessors => Blogel.additional_post_fields
    scoped_search :on => Blogel.post_search_fields
    
    validates_presence_of :title, :slug, :content
    attr_readonly :slug
    
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
    def self.from_category category_id, page_number = 1, fetch_from_subcategories = false
      cat = Category.includes(:children_categories, :posts).where((category_id.kind_of?(String) ? :slug : :id) => category_id).first
      if cat
        Category.includes(:posts).page(page_number).where('id IN (?)', cat.children_categories.length > 0 && fetch_from_subcategories ? [cat.id].concat(cat.children_categories.map(&:id)) : [cat.id]).map {|c| c.posts.includes(:tags, :categories, :comments).order('published_at DESC, created_at DESC')}.flatten
      else
        []
      end
    end

    def highlight_search_terms! search_terms, tag = :span, options = {}
      search_terms.split(/\s/).each do |t|
        rgx = /#{Regexp.escape(t)}/i
        Blogel.post_search_fields.each do |sf|
          send(sf).gsub!(rgx) {|f| content_tag(tag, f, options)}
        end
      end
      self
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

    def breadcrumbs include_article_title = false, show_uncategorized = true
      @_breadcrumbs ||= lambda {
        if categories.first
          parents = [categories.first.name]
          cat = categories.first
          while cat.parent_category
            cat = cat.parent_category
            parents.unshift(cat.name) if cat
          end
          parents
        else 
          [I18n.t('blogel.labels.posts.uncategorized')]
        end
      }.call
    end
  end
end
