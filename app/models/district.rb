class District < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :province_id
  belongs_to :province
  has_many :subdistricts

  searchable do
    text :name
  end

  def get_subdistricts_number
    number = 0
    if self.subdistricts != nil
      number += self.subdistricts.size
    end

    return number
  end

  def get_activities_number
    number = 0
    self.subdistricts.each do |subdistrict|
      if subdistrict.activities != nil
        number += subdistrict.activities.size
      end
    end
    
    return number
  end

  def get_province_name
  	name = ''
  	if self.province != nil
  		name = self.province.name
  	end

  	return name;
  end
end
