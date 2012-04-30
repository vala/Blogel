class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :blogel_posts, :user_id, :integer
  end
end
