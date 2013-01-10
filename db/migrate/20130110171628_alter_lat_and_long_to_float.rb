class AlterLatAndLongToFloat < ActiveRecord::Migration
  def up
  	change_column :provinces, :latitude, :float
  	change_column :provinces, :longitude, :float
  	change_column :districts, :latitude, :float
  	change_column :districts, :longitude, :float
  	change_column :subdistricts, :latitude, :float
  	change_column :subdistricts, :longitude, :float
    change_column :projects, :latitude, :float
    change_column :projects, :longitude, :float
  end

  def down
  	change_column :provinces, :latitude, :decimal
  	change_column :provinces, :longitude, :decimal
  	change_column :districts, :latitude, :decimal
  	change_column :districts, :longitude, :decimal
  	change_column :subdistricts, :latitude, :decimal
  	change_column :subdistricts, :longitude, :decimal
    change_column :projects, :latitude, :decimal
    change_column :projects, :longitude, :decimal
  end
end
