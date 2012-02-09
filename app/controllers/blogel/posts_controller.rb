module Blogel
  class PostsController < ::ApplicationController
    before_filter :"authorize_#{Blogel.user_model_name.underscore}!", :only => [:comment]
    layout Blogel.blog_layout
    
    def index
      @posts = Post.ordered
    end
    
    def filter
      @posts = Post.from_category(params[:category])
    end
  
    def show
      @post = Post.find_by_slug(params[:id])
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
  end
end
