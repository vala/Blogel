module Blogel
  class TagsController < ApplicationController
    layout Blogel.blog_layout
    
    def index
      tags = Tag.order('name ASC')
      @tags = Hash[('a'..'z').map {|letter| [letter, tags.reject {|tag| !tag.name.match(/^#{letter}/i)}]}]
    end
  end
end