class AlterLatLongForSubdistrict < ActiveRecord::Migration
  def up
    change_column :provinces, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :provinces, :longitude, :decimal, :precision => 11, :scale => 8
    change_column :districts, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :districts, :longitude, :decimal, :precision => 11, :scale => 8
    change_column :subdistricts, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :subdistricts, :longitude, :decimal, :precision => 11, :scale => 8
  end

  def down
    change_column :provinces, :latitude, :float
    change_column :provinces, :longitude, :float
    change_column :districts, :latitude, :float
    change_column :districts, :longitude, :float
    change_column :subdistricts, :latitude, :float
    change_column :subdistricts, :longitude, :float
  end
end
