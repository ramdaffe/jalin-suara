class Activity < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :picture, :description
  acts_as_gmappable validation: false

  def gmaps4rails_address
	  "#{self.name}" 
	end

  has_attached_file :picture, styles: {
  	tiny: '50x50',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
end