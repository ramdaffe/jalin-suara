class CreateSubdistricts < ActiveRecord::Migration
  def change
    create_table :subdistricts do |t|
      t.string :name
      t.integer :city_id
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
