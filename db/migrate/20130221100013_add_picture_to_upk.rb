class AddPictureToUpk < ActiveRecord::Migration
  def change
  	add_attachment :implementer_units, :picture
  end
end
