class Subdistrict < ActiveRecord::Base
  attr_accessible :district_id, :latitude, :longitude, :name
  belongs_to :district

  def get_district_name
  	name = ''
  	if self.district != nil
  		name = self.district.name
  	end

  	return name
  end
end
