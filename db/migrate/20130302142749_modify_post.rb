class ModifyPost < ActiveRecord::Migration
  def up
    add_column :posts, :latitude, :decimal, :precision => 11, :scale => 8
    add_column :posts, :longitude, :decimal, :precision => 11, :scale => 8
    add_column :posts, :gmaps, :boolean
    add_column :posts, :budget, :bigint
    add_column :posts, :dimension, :integer
    add_column :posts, :beneficiary, :integer
    add_column :posts, :postable_id, :integer
    add_column :posts, :postable_type, :string
  end

  def down
    remove_column :posts, :latitude
    remove_column :posts, :longitude
    remove_column :posts, :gmaps
    remove_column :posts, :budget
    remove_column :posts, :dimension
    remove_column :posts, :beneficiary
    remove_column :posts, :postable_id
    remove_column :posts, :postable_type
  end
end

