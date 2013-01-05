class City < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :province_id
end
