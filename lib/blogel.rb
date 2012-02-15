require "blogel/engine"
require "blogel/helpers"

module Blogel
  mattr_accessor :app_root
  
  # Default user configuration
  mattr_accessor :user_model_name
  @@user_model_name = 'User'
  
  # Default current user method
  mattr_accessor :current_user_method
  @@current_user_method = 'current_user'
  
  # Add more fields to posts
  mattr_accessor :additional_post_fields
  @@additional_post_fields = []
  
  # Fields to search with search action in posts controller
  mattr_accessor :post_search_fields
  @@post_search_fields = [:title, :content]
  
  # Add more styles to post images
  mattr_accessor :additional_post_image_styles
  @@additional_post_image_styles = {}
  
  # Layout for the posts controller
  mattr_accessor :blog_layout
  @@blog_layout = 'application'
  
  # Config block for the initializer
  def self.config
    yield self
  end
end
