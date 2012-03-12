class CreateBlogelTags < ActiveRecord::Migration
  def change
    create_table :blogel_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
