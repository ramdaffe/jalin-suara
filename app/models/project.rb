class Project < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :subdistrict_id
  belongs_to :subdistrict

  acts_as_gmappable

  def gmaps4rails_address
	  "#{self.name}" 
	end

  def get_subdistrict_name
  	name = ''
  	if self.subdistrict != nil
  		name = self.subdistrict.name
  	end

  	return name
  end
end
