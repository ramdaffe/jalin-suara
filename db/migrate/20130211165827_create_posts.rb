class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end

    add_attachment :posts, :picture
  end
end
