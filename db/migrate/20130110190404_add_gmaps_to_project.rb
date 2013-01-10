class AddGmapsToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :gmaps, :boolean
  end
end
