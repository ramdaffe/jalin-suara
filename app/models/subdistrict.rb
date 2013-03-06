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
end
