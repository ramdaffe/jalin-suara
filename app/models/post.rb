class Post < ActiveRecord::Base
  attr_accessible :title, :activity_id, :description, :user_id, :picture
  belongs_to :activity
  belongs_to :user

  has_attached_file :picture, :default_url => "/images/missing/:class_:attachment_:style.jpg", styles: {
  	tiny: '50x50',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '400x400'
  }
end
