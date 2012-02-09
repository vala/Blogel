module Blogel
  class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user, :class_name => Blogel.user_model_name, :foreign_key => 'user_id'
  end
end
