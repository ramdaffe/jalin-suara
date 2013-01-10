class District < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :province_id
  belongs_to :province
  has_many :subdistricts

  def get_province_name
  	name = ''
  	if self.province != nil
  		name = self.province.name
  	end

  	return name;
  end
end
