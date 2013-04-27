class Province < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name
  has_many :districts

  searchable do
    text :name
  end

  def get_districts_number
  	number = 0
  	if self.districts != nil
  		number = self.districts.count
  	end

  	return number
  end

  def get_subdistricts_number
  	number = 0
  	self.districts.each do |district|
  		if district.subdistricts != nil
  			number += district.subdistricts.count
			end
		end

  	return number
  end

  def get_activities_number
  	number = 0
		self.districts.each do |district|
			district.subdistricts.each do |subdistrict|
				if subdistrict.activities != nil
					number += subdistrict.activities.count
				end
			end
		end
  	
  	return number
  end

  def get_total_blm_amount
  	amount = 0
    self.districts.each do |district|
      district.subdistricts.each do |subdistrict|
        subdistrict.activities.each do |activity|
          amount += activity.blm_amount
        end
      end
    end
  	return amount
  end

  def get_total_self_fund_amount
  	amount = 0
    self.districts.each do |district|
      district.subdistricts.each do |subdistrict|
        subdistrict.activities.each do |activity|
          amount += activity.self_fund_amount
        end
      end
    end
  	return amount
  end
end
