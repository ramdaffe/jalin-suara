class Activity < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :picture

  has_attached_file :picture, styles: {
  	tiny: '50x50',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
end
