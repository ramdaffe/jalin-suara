class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :province_id
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
