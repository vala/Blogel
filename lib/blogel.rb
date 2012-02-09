require "blogel/engine"

module Blogel
  mattr_accessor :app_root, :user_model, :current_user_method, :additional_post_fields
  
  # Default user configuration
  @@user_model_name = 'User'
  @@current_user_method = 'current_user'
  @@additional_post_fields = []
  @@additional_post_image_styles = {}
  
  # Config block for the initializer
  def self.config
    yield self
  end
end
