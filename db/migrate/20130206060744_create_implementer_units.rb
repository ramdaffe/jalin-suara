class CreateImplementerUnits < ActiveRecord::Migration
  def change
    create_table :implementer_units do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :facilitator
      t.string :facilitator_phone
      t.string :call_center
      t.integer :subdistrict_id

      t.timestamps
    end
  end
end
