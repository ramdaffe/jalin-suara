class ReturnToFloat < ActiveRecord::Migration
  def up
    change_column :activities, :latitude, :float
    change_column :activities, :longitude, :float
    change_column :subdistricts, :latitude, :float
    change_column :subdistricts, :longitude, :float
    change_column :posts, :latitude, :float
    change_column :posts, :longitude, :float
  end

  def down
    change_column :activities, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :activities, :longitude, :decimal, :precision => 15, :scale => 12
    change_column :subdistricts, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :subdistricts, :longitude, :decimal, :precision => 15, :scale => 12
    change_column :posts, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :posts, :longitude, :decimal, :precision => 15, :scale => 12
  end
end
