class DecimalLatLong < ActiveRecord::Migration
  def up
    hange_column :activities, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :activities, :longitude, :decimal, :precision => 15, :scale => 10
    change_column :subdistricts, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :subdistricts, :longitude, :decimal, :precision => 15, :scale => 10
    change_column :posts, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :posts, :longitude, :decimal, :precision => 15, :scale => 10
  end

  def down
    hange_column :activities, :latitude, :float, :precision => 11, :decimal => 8
    change_column :activities, :longitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :longitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :longitude, :float, :precision => 11, :decimal => 8
  end
end
