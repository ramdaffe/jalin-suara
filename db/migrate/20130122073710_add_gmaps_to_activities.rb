class AddGmapsToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :gmaps, :boolean
  end
end
