class Activity < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :picture, :description, :project_length, :project_area, :project_quantity, :blm_amount, :self_fund_amount, :male_proposal, :female_proposal, :male_beneficiary, :female_beneficiary, :poor_beneficiary, :subdistrict_id, :category_id
  acts_as_gmappable validation: false
  belongs_to :subdistrict
  belongs_to :category
  has_many :posts, :as => :postable

  has_attached_file :picture, 
    :styles => {
      tiny: '50x50',
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

  searchable do
    text :name, :description
  end

  def get_subdistrict_name
    name = ''
    if self.subdistrict != nil
      name = self.subdistrict.name
    end

    return name
  end

  def get_district_name
    name = ''
    if self.subdistrict != nil
      name = self.subdistrict.get_district_name
    end

    return name
  end

  def get_province_name
    name = ''
    if self.subdistrict != nil
      if self.subdistrict.district != nil
        name = self.subdistrict.district.get_province_name
      end
    end

    return name
  end

  def get_category_name
    name = ''
    if self.category != nil
      name = self.category.name
    end

    return name
  end

  def gmaps4rails_address
	  "#{self.get_subdistrict_name} - #{self.name}" 
	end

  def gmaps4rails_infowindow
    info = ""
    info << "<h5>#{self.get_subdistrict_name}</h5>"
    i = 0
    if self.subdistrict != nil
      self.subdistrict.activities.each do |activity|
        i += 1
        info << "<b>#{i}. #{activity.name}</b><br/>"
        info << "Jumlah Penerima Manfaat: #{activity.male_beneficiary + activity.female_beneficiary}<br/>"
        info << "Jumlah BLM: #{activity.blm_amount}<br/>"
        info << "<a href='localhost:3000/activities/#{activity.id}'>Lihat selengkapnya</a><br/><br/>"
      end
    end

    return info
  end

  def gmaps4rails_title
    "#{self.name} - #{self.get_subdistrict_name}"
  end

  # def find_by_filter(province_name, district_name, subdistrict_name, activity_name)
  #   subdistricts_array = []
  #   provinces = Province.find(:all, :conditions => ["name like '?'", "%#{province_name}%"])
  #   provinces.each do |province|
  #     province.districts.each do |district|
  #       district.subdistricts.each do |subdistrict|
  #         subdistricts_array << subdistrict.id
  #       end
  #     end
  #   end
  #   self.find(:all, :conditions => ["subdistrict_id in ?", subdistricts_array])
  # end
end