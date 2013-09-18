class ImproveLatLongPrecision < ActiveRecord::Migration
  def up
    change_column :activities, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :activities, :longitude, :decimal, :precision => 15, :scale => 12
    change_column :subdistricts, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :subdistricts, :longitude, :decimal, :precision => 15, :scale => 12
    add_column :subdistricts, :gmaps, :boolean
  end

  def down
    change_column :activities, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :activities, :longitude, :decimal, :precision => 11, :scale => 8
    change_column :subdistricts, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :subdistricts, :longitude, :decimal, :precision => 11, :scale => 8
    remove_column :subdistricts, :gmaps
  end
end
