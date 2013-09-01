class AddGuestCommentToOpinio < ActiveRecord::Migration
  def change
    add_column :comments, :guest_name, :string
    add_column :comments, :guest_email, :string
  end
end
