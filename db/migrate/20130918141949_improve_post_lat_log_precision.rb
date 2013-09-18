class ImprovePostLatLogPrecision < ActiveRecord::Migration
  def up
    change_column :posts, :latitude, :decimal, :precision => 15, :scale => 12
    change_column :posts, :longitude, :decimal, :precision => 15, :scale => 12
  end

  def down
    change_column :posts, :latitude, :decimal, :precision => 11, :scale => 8
    change_column :posts, :longitude, :decimal, :precision => 11, :scale => 8
  end
end
