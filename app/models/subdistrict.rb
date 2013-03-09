class Subdistrict < ActiveRecord::Base
  attr_accessible :district_id, :latitude, :longitude, :name
  belongs_to :district
  has_one :implementer_unit
  has_many :activities
  has_many :posts, :as => :postable

  searchable do
    text :name
  end

  def get_district_name
  	name = ''
  	if self.district != nil
  		name = self.district.name
  	end

  	return name
  end

  def get_province_name
    name = ''
    if self.district != nil
      name = self.district.get_province_name
    end

    return name
  end

  def get_activities_number
    number = 0
    if self.activities != nil
      number += self.activities.size
    end
    
    return number
  end
end
