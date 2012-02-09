class CreateBlogelComments < ActiveRecord::Migration
  def change
    create_table :blogel_comments do |t|
      t.string :title
      t.text :content
      t.integer :post_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
