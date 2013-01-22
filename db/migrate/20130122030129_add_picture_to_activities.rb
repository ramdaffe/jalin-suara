class AddPictureToActivities < ActiveRecord::Migration
  def change
  	add_attachment :activities, :picture
  end
end
