class Province < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name
  has_many :districts

  def get_districts_number
  	number = 0
  	if self.districts != nil
  		number = self.districts.size
  	end

  	return number
  end

  def get_subdistricts_number
  	number = 0
  	self.districts.each do |district|
  		if district.subdistricts != nil
  			number += district.subdistricts.size
			end
		end

  	return number
  end

  def get_activities_number
  	number = 0
		self.districts.each do |district|
			district.subdistricts.each do |subdistrict|
				if subdistrict.activities != nil
					number += subdistrict.activities.size
				end
			end
		end
  	
  	return number
  end

  def get_total_blm_amount
  	amount = 0
  	return amount
  end

  def get_total_self_fund_amount
  	amount = 0
  	return amount
  end
end
