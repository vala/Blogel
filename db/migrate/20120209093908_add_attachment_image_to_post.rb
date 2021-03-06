class AddAttachmentImageToPost < ActiveRecord::Migration
  def self.up
    add_column :blogel_posts, :image_file_name, :string
    add_column :blogel_posts, :image_content_type, :string
    add_column :blogel_posts, :image_file_size, :integer
    add_column :blogel_posts, :image_updated_at, :datetime
  end

  def self.down
    remove_column :blogel_posts, :image_file_name
    remove_column :blogel_posts, :image_content_type
    remove_column :blogel_posts, :image_file_size
    remove_column :blogel_posts, :image_updated_at
  end
end
