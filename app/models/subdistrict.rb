class Subdistrict < ActiveRecord::Base
  resourcify
  attr_accessible :district_id, :latitude, :longitude, :name
  acts_as_gmappable validation: false, process_geocoding: true, lat: "latitude", long: "longitude"
  belongs_to :district
  has_one :implementer_unit
  has_many :activities
  has_many :posts, :as => :postable

  searchable do
    text :name
  end

  def gmaps4rails_address
    "#{self.name}, #{self.get_district_name}, #{self.get_province_name}, Indonesia" 
  end

  def gmaps4rails_infowindow
    info = ""
    info << "<h5>#{self.name}</h5>"
    i = 0

    if self.activities != nil
      self.activities.each do |activity|
        i = i+1
        info << "<b>#{i}. #{activity.name}</b><br/>"
        info << "Jumlah Penerima Manfaat: #{activity.male_beneficiary}<br/>"
        info << "Jumlah BLM: #{activity.blm_amount}<br/>"
        info << "<a href='/activities/#{activity.id}'>Lihat selengkapnya</a><br/><br/>"
      end
    end

    return info
  end

  def gmaps4rails_title
    "#{self.name}"
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

  def get_total_male_beneficiary
    number = 0
    if self.activities != nil
      number = self.activities.sum(:male_beneficiary)
    end

    return number
  end

  def get_total_female_beneficiary
    number = 0
    if self.activities != nil
      number = self.activities.sum(:female_beneficiary)
    end

    return number
  end

  def get_total_poor_beneficiary
    number = 0
    if self.activities != nil
      number = self.activities.sum(:poor_beneficiary)
    end

    return number
  end

  def get_total_blm_amount
    number = 0
    if self.activities != nil
      number = self.activities.sum(:blm_amount)
    end

    return number
  end

  def get_total_self_fund_amount
    number = 0
    if self.activities != nil
      number = self.activities.sum(:self_fund_amount)
    end

    return number
  end
end
