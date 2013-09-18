class ImproveFloatPrecision < ActiveRecord::Migration
  def up
    change_column :activities, :latitude, :float, :precision => 11, :decimal => 8
    change_column :activities, :longitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :longitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :longitude, :float, :precision => 11, :decimal => 8
  end

  def down
    change_column :activities, :latitude, :float, :precision => 11, :decimal => 8
    change_column :activities, :longitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :subdistricts, :longitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :latitude, :float, :precision => 11, :decimal => 8
    change_column :posts, :longitude, :float, :precision => 11, :decimal => 8
  end
end
