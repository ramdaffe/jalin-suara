class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :subdistrict_id
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
