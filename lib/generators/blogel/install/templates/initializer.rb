# encoding: utf-8

Blogel.config do |config|
  # Define your user model here
  # config.user_model = Blogel::BlogUser

  # What is you current_user method ?
  # config.current_user_method = ''

  # Add additional fields to the posts with ActiveRecord::Base.store
  # config.additional_post_fields = [:subtitle]

  # Sets how much posts you want to show per page on all listing pages (index, filter, search)
  # config.post_per_page = 10

  # Set which posts fields should be searched
  # config.post_search_fields = [:title, :content]

  # Add additional paperclip image styles to posts' main images
  # config.additional_post_image_styles

  # Modify blog's layout file
  # config.blog_layout = 'application'

  if defined?(RailsAdmin)
    RailsAdmin.config do |config|
      config.model Blogel::Post do
        list do
          field :title
          field :published
          field :categories
          field :published_at
        end

        edit do
          if defined? Rich
            configure :content, :rich_editor
          end
          field :title
          field :published
          field :categories
          field :image
          field :content do
            if defined? Ckeditor
              ckeditor true
            end
          end
        end
      end

      config.model Blogel::Category do
        nestable_tree({
          position_field: :position,
          max_depth: 3
        })
        list do
          sort_by :ancestry
          sort_reverse false
          field :name
        end

        edit do
          field :name
          field :description
        end
      end

      config.model Blogel::Comment do

      end
    end
  end
end