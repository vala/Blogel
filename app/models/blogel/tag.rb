module Blogel
  class Tag < ActiveRecord::Base
    self.table_name = 'blogel_tags'
    has_and_belongs_to_many :posts, :join_table => "blogel_posts_tags", :foreign_key => 'tag_id'
    attr_accessible :posts, :post_ids, :name
  end
end
