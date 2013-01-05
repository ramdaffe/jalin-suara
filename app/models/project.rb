class Project < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :subdistrict_id
end
