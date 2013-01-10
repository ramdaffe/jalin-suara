class AlterCityIdInSubdistrict < ActiveRecord::Migration
  def up
  	rename_column :subdistricts, :city_id, :district_id
  end

  def down
  	rename_column :subdistricts, :district_id, :city_id
  end
end
