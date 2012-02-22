module Blogel
  class PostsController < ::ApplicationController
    before_filter :"authorize_#{Blogel.user_model_name.underscore}!", :only => [:comment]
    before_filter :init
    layout Blogel.blog_layout
    
    def index
      @posts = Post.ordered
    end
    
    def filter
      @current_category = params[:category]
      @posts = Post.from_category(params[:category], true)
      if @posts.length > 0
        page_title @posts.first.breadcrumbs.join(' / ')
      else
        page_title I18n.t('blogel.labels.posts.no_posts_were_found')
      end
    end
    
    def search
      @search_terms = params[:q]
      @posts = Post.search_for(params[:q]).each {|post| post.highlight_search_terms!(params[:q], :span, :class => 'found_search_term')}
      page_title "#{I18n.t('blogel.labels.misc.search')} : #{params[:q]}"
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
        page_title = nil
      end
      
      def page_title title
        @page_title = (title ? "#{title} - " : '') + I18n.t('blogel.pages.title.posts')
      end
  end
end
