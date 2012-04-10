module Blogel
  class PostsController < ::ApplicationController
    before_filter :"authorize_#{Blogel.user_model_name.underscore}!", :only => [:comment]
    before_filter :init
    layout Blogel.blog_layout
    
    def index
      @posts = Post.includes(:tags, :categories, :comments).page(@page_number).ordered
    end
    
    def filter
      @current_category = params[:category]
      @posts = Post.from_category(params[:category], @page_number, true)
      if @posts.length > 0
        page_title @posts.first.breadcrumbs.join(' / ')
      else
        page_title I18n.t('blogel.labels.posts.no_posts_were_found')
      end
    end
    
    def filter_by_tag
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.includes(:tags, :categories, :comments).page(@page_number).order('created_at DESC')
      page_title t('blogel.labels.titles.tags', :tag => @tag.name)
      render 'filter'
    end
    
    def search
      @search_terms = params[:q]
      @posts = Post.search_for(params[:q]).includes(:tags, :categories, :comments).order('created_at DESC').page(@page_number).each {|post| post.highlight_search_terms!(params[:q], :span, :class => 'found_search_term')}
      page_title t('blogel.labels.titles.search', :terms => params[:q])
    end
    
    def show
      @post = Post.find_by_slug(params[:id])
      page_title @post.title
    end
  
    def comment
      comment = Comment.new params[:comment]
      if comment.save
        flash[:notice] = t('blogel.messages.comment_successfully_added')
      else
        flash[:alert] = t('blogel.messages.comment_couldnt_be_added')
      end
      redirect_to :back
    end
    
    protected
      def init
        page_title nil
        @page_number = params[:page] || 1
      end
      
      def page_title title
        @page_title = (title ? "#{title} - " : '') + I18n.t('blogel.pages.title.posts')
      end
  end
end
