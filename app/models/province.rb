class Province < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name
  has_many :districts
end
